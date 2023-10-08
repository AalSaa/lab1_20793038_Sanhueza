#lang racket

; ######################################## TDA OPTION ########################################

; ######################################## REPRESENTACION ####################################

; Este TDA corresponde a una opcion.
; Dentro se guardara un id de la opcion, un mensaje, un id de chatbot, un id de flujo 
; y una lista de palabras que caracterizan a la opcion.

; ######################################## CONSTRUCTOR #######################################

; Descripcion: Funcion que construye una opcion.
; Dom: id (int) X message (string) X chatbot-codelink (int) X flow-codelink (int) X keyword (list)
; Rec: option (list)
; Recursion: -
(define option (lambda (id message chatbot-codelink flow-codelink . keyword)
    (list 
        id 
        (string-downcase message) 
        chatbot-codelink 
        flow-codelink 
        (map string-downcase keyword)
        )
))

; ######################################## PERTENENCIA #######################################

; Descripcion: Funcion recursiva que verifica si existe una opcion que tenga el id o palabra clave
;              indicado.
; Dom: option-list (list) X message (string)
; Rec: boolean
; Recursion: cola
(define option-exists-by-message?-rec (lambda (option-list message)
    (define aux (lambda (ol message)
        (if (null? ol)
            #f
            (if (or (not (boolean? (member message (get-option-keyword (car ol)))))
                    (string=? message (number->string (get-option-id (car ol)))))
                #t
                (aux (cdr ol) message)        
            )
        )
    ))
    (aux option-list message)
))

; Descripcion: Funcion no recursiva que verifica si existe una opcion que tenga el id o palabra clave
;              indicado.
; Dom: option-list (list) X message (string)
; Rec: boolean
; Recursion: -
(define option-exists-by-message?-norec (lambda (option-list message)
    (not (null?
        (filter 
            (lambda (o)
                (or (not (boolean? (member message (get-option-keyword o))))
                    (string=? message (number->string (get-option-id o))))
            )
            option-list
        )
    ))
))

; ######################################## SELECTOR ##########################################

; Descripcion: Funcion que obtiene el id de una opcion.
; Dom: option (list)
; Rec: id (int)
; Recursion: -
(define get-option-id (lambda (option)
    (list-ref option 0)    
))

; Descripcion: Funcion que obtiene el mensaje de una opcion.
; Dom: option (list)
; Rec: message (string)
; Recursion: -
(define get-option-message (lambda (option)
    (list-ref option 1)
))

; Descripcion: Funcion que obtiene el id del chatbot enlazado a la opcion.
; Dom: option (list)
; Rec: cb-codelink (int)
; Recursion: -
(define get-option-cb-codelink (lambda (option)
    (list-ref option 2)
))

; Descripcion: Funcion que obtiene el id del flujo enlazado a la opcion.
; Dom: option (list)
; Rec: fl-codelink (int)
; Recursion: -
(define get-option-fl-codelink (lambda (option)
    (list-ref option 3)
))

; Descripcion: Funcion que obtiene las palabras claves relacionadas a la opcion.
; Dom: option (list)
; Rec: keyword (list)
; Recursion: -
(define get-option-keyword (lambda (option)
    (list-ref option 4)
))

; Descripcion: Funcion recursiva que obtiene una opcion a partir de su id o palabra clave.
; Dom: option-list (list) X message (string)
; Rec: option (list)
; Recursion: cola
(define get-option-by-message-rec (lambda (option-list message)
    (define aux (lambda (ol message)
        (if (or (not (boolean? (member message (get-option-keyword (car ol)))))
                (string=? message (number->string (get-option-id (car ol)))))
                (car ol)
                (aux (cdr ol) message)        
        )
    ))
    (aux option-list message)
))

; Descripcion: Funcion no recursiva que obtiene una opcion a partir de su id o palabra clave.
; Dom: option-list (list) X message (string)
; Rec: option (list)
; Recursion: -
(define get-option-by-message-norec (lambda (option-list message)
    (car (filter 
        (lambda (o)
            (or (not (boolean? (member message (get-option-keyword o))))
                (string=? message (number->string (get-option-id o))))
        )
        option-list
    ))
))

; ######################################## EXPORTACION DE FUNCION ############################

(provide (all-defined-out))