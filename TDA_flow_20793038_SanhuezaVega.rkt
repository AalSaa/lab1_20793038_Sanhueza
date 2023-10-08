#lang racket

; ######################################## LLAMADO DE TDA TOOLS ##############################

(require "TDA_tools_20793038_SanhuezaVega.rkt")

; ######################################## TDA FLOW ##########################################

; ######################################## REPRESENTACION ####################################

; Este TDA corresponde a un flujo.
; Dentro se guardara un id del flujo, un nombre para el flujo y una lista de opciones.

; ######################################## CONSTRUCTOR #######################################

; Descripcion: Funcion que crea un flujo.
; Dom: id (int) X name (string) X option (list)
; Rec: flow (list)
; Recursion: -
(define flow (lambda (id name . option)
    (set-flow 
        id 
        (string-downcase name) 
        (add-elements-in-list option null)
    )
))

; Descripcion: Funcion que construye un flujo.
; Dom: id (int) X name (string) X op-list (list) 
; Rec: flow (list)
; Recursion: -
(define set-flow (lambda (id name op-list)
    (list id name op-list)
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

; ######################################## MODIFICADOR #######################################

; Descripcion: Funcion que añade una funcion a un flujo.
; Dom: id (int) X name (string) X option (list)
; Rec: flow (list)
; Recursion: -
(define flow-add-option (lambda (flow option)
    (if (id-exists? option (get-flow-op-list flow))
        flow
        (set-flow 
            (get-flow-id flow)
            (get-flow-name flow)
            (append (get-flow-op-list flow) (list option))
        )
    )
))

; ######################################## EXPORTACION DE FUNCION ############################

(provide (all-defined-out))
