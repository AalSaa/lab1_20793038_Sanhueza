#lang racket

; ######################################## TDA FLOW ##########################################

; ######################################## REPRESENTACION ####################################

; Este TDA corresponde a una flujo.
; Dentro se guardara un id del flujo, un nombre para el flujo y una lista de opciones.

; ######################################## CONSTRUCTOR #######################################

; Descripcion: Funcion que crea un flujo.
; Dom: id (int) X name (string) X option (list)
; Rec: flow (list)
; Recursion: -
(define flow (lambda (id name . option)
    (set-flow id name (add-options-in-list option null))
))

; ######################################## PERTENENCIA #######################################

; Descripcion: Funcion que filtra opciones que tengan el id indicado.
; Dom: option-id (int) X op-list (list)
; Rec: filtered-o-list (list)
; Recursion: -
(define has-same-option-id? (lambda (option-id op-list)
    (filter 
        ((lambda (option-id) (lambda (option) (if (= option-id (get-option-id option)) #t #f)))
        option-id)
        op-list
    )
))

; Descripcion: Funcion que identifica si el id indicado ya existe dentro de una lista.
; Dom: option (list) X op-list (list)
; Rec: boolean
; Recursion: -
(define option-id-exists? (lambda (option op-list)
    (if (null? (has-same-option-id? (get-option-id option) op-list)) #f #t)
))

; ######################################## SELECTOR ##########################################

; Descripcion: Funcion que obtiene el id del flujo.
; Dom: flow (list)
; Rec: id (int)
; Recursion: -
(define get-flow-id (lambda (flow)
    (list-ref flow 0)
))

; Descripcion: Funcion que obtiene el nombre del flujo.
; Dom: flow (list) 
; Rec: name (string)
; Recursion: -
(define get-flow-name (lambda (flow)
    (list-ref flow 1)
))

; Descripcion: Funcion que obtiene la lista de opciones dentro de un flujo. 
; Dom: flow (list)
; Rec: option-list (list)
; Recursion: -
(define get-flow-op-list (lambda (flow)
    (list-ref flow 2)
))

; Descripcion: Funcion que obtiene el id de una opcion.
; Dom: option (list)
; Rec: option-id (int)
; Recursion: -
(define get-option-id (lambda (option)
    (list-ref option 0)
))

; ######################################## MODIFICADOR #######################################

; Descripcion: Funcion que añade una funcion a un flujo.
; Dom: id (int) X name (string) X option (list)
; Rec: flow (list)
; Recursion: -
(define flow-add-option (lambda (flow option)
    (if (option-id-exists? option (get-flow-op-list flow))
        flow
        (set-flow 
            (get-flow-id flow)
            (get-flow-name flow)
            (append (get-flow-op-list flow) (list option))
        )
    )
))

; Descripcion: Funcion que actualiza el flujo.
; Dom: id (int) X name (string) X op-list (list) 
; Rec: flow (list)
; Recursion: -
(define set-flow (lambda (id name op-list)
    (list id name op-list)
))

; Descripcion: Funcion que va agregando opciones dentro de una lista.
; Dom: options (list) X op_list (list)
; Rec: op_list (list)
; Recursion: cola
(define add-options-in-list (lambda (options op-list)
    (if (null? options)
        op-list
        (if (option-id-exists? (car options) op-list)
            (add-options-in-list (cdr options) op-list)
            (add-options-in-list (cdr options) (append op-list (list (car options))))
        )
    )
))

; ######################################## EXPORTACION DE FUNCION ############################

(provide flow flow-add-option)
