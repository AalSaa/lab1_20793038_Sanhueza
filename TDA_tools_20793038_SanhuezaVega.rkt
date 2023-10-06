#lang racket

; ######################################## TDA TOOLS #########################################

; ######################################## REPRESENTACION ####################################

; Este TDA corresponde a las herramientas.
; Se utilizara casos similares dentro de los demas TDA.

; ######################################## PERTENENCIA #######################################

; Descripcion: Funcion que revisa si el id de un elemento ya existe en una lista de elementos.
; Dom: element (list) X elements-list (list)
; Rec: boolean
; Recursion: -
(define id-exists? (lambda (element elements-list)
    (define aux (lambda (id elements-list)
        (filter 
            ((lambda (id) (lambda (element) (if (= id (get-id element)) #t #f)))
            id) elements-list
        )
    ))

    (if (null? (aux (get-id element) elements-list)) #f #t)
))

; ######################################## SELECTOR ##########################################

; Descripcion: Funcion que obtiene el id de un elemento.
; Dom: element (list)
; Rec: id (int)
; Recursion: -
(define get-id (lambda (element)
    (list-ref element 0)
))

; Descripcion: Funcion que obtiene un elemento segun su id.
; Dom: id (int) X element-list (list)
; Rec: element (list)
; Recursion: -
(define get-element-by-id (lambda (id elements-list)
    (define aux (lambda (id elements-list)
        (filter 
            ((lambda (id) (lambda (element) (if (= id (get-id element)) #t #f)))
            id) elements-list
        )
    ))

    (list-ref (aux id elements-list) 0)
))

; ######################################## MODIFICADOR #######################################

; Descripcion: Funcion que añade elementos a una lista evitando que se repita el id.
; Dom: elements (list) X elements-list (list)
; Rec: elements-list (list)
; Recursion: -
(define add-elements-in-list (lambda (elements elements-list)
    (if (null? elements)
        elements-list
        (if (id-exists? (car elements) elements-list)
            (add-elements-in-list (cdr elements) elements-list)
            (add-elements-in-list (cdr elements) (append elements-list (list (car elements))))
        )
    )
))

; ######################################## EXPORTACION DE FUNCION ############################

(provide (all-defined-out))