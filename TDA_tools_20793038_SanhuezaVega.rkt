#lang racket

; ######################################## TDA TOOLS #########################################

; ######################################## REPRESENTACION ####################################

; Este TDA corresponde a las herramientas.
; Se utilizara casos similares dentro de los demas TDA.

; ######################################## PERTENENCIA #######################################

; Descripcion: Funcion que filtra a los elementos que tengan el id indicado.
; Dom: id (int) X e-list (list)
; Rec: filtered-e-list (list)
; Recursion: -
(define has-same-id? (lambda (id e-list)
    (filter 
        ((lambda (id) (lambda (element) (if (= id (get-id element)) #t #f))) id)
        e-list
    )
))

; Descripcion: Funcion que revisa si el id de un elemento ya existe en una lista de elementos.
; Dom: element (list) X e-list (list)
; Rec: boolean
; Recursion: -
(define id-exists? (lambda (element e-list)
    (if (null? (has-same-id? (get-id element) e-list)) #f #t)
))

; ######################################## SELECTOR ##########################################

; Descripcion: Funcion que obtiene el id de un elemento.
; Dom: element (list)
; Rec: id (int)
; Recursion: -
(define get-id (lambda (element)
    (list-ref element 0)
))

; ######################################## MODIFICADOR #######################################

; Descripcion: Funcion que añade elementos a una lista evitando que se repita el id.
; Dom: elements (list) X e-list (list)
; Rec: e-list (list)
; Recursion: -
(define add-elements-in-list (lambda (elements e-list)
    (if (null? elements)
        e-list
        (if (id-exists? (car elements) e-list)
            (add-elements-in-list (cdr elements) e-list)
            (add-elements-in-list (cdr elements) (append e-list (list (car elements))))
        )
    )
))

; ######################################## EXPORTACION DE FUNCION ############################

(provide get-id id-exists? add-elements-in-list)