#lang racket

; ######################################## LLAMADO DE TDA´s ##################################

(require "TDA_date_20793038_SanhuezaVega.rkt")
(require "TDA_tools_20793038_SanhuezaVega.rkt")

; ######################################## TDA SYSTEM ########################################

; ######################################## REPRESENTACION ####################################

; Este TDA corresponde a un sistema.
; Dentro se guardara la fecha de creacion, el nombre del sistema, el id del primer chatbot a
; utilizar, una lista de usuarios, un historial del uso de los chatbots y una lista de
; chatbots.

; ######################################## CONSTRUCTOR #######################################

; Descripcion: Funcion que construye un sistema.
; Dom: name (string) X chatbot (list)
; Rec: system (list)
; Recursion: -
(define system (lambda (name initial-chatbot-code-link . chatbot)
    (set-system
        (make-current-date)
        name
        initial-chatbot-code-link
        null
        null
        (add-elements-in-list chatbot null)
    )
))

; ######################################## SELECTOR ##########################################

; Descripcion: Funcion que obtiene la fecha de creacion del sistema.
; Dom: system (list)
; Rec: system-date (list)
; Recursion: -
(define get-system-date (lambda (system)
    (list-ref system 0)
))

; Descripcion: Funcion que obtiene el nombre del sistema.
; Dom: system (list)
; Rec: system-name (string)
; Recursion: -
(define get-system-name (lambda (system)
    (list-ref system 1)
))

(define get-initial-cb-code-link (lambda (system)
    (list-ref system 2)
))

; Descripcion: Funcion que obtiene la lista de usuarios del sistema.
; Dom: system (list)
; Rec: system-users (list)
; Recursion: -
(define get-system-users (lambda (system)
    (list-ref system 3)
))

(define get-chat-history (lambda (system)
    (list-ref system 4)
))

; Descripcion: Funcion que obtiene la lista de opciones dentro del sistema.
; Dom: system (list)
; Rec: chatbot-list (list)
; Recursion: -
(define get-system-cb-list (lambda (system)
    (list-ref system 5)
))

; ######################################## MODIFICADOR #######################################

; Descripcion: Funcion que añade un nuevo chatbot al sistema.
; Dom: system (list) X chatbot (list)
; Rec: system (list)
; Recursion: -
(define system-add-chatbot (lambda (system chatbot)
    (if (id-exists? chatbot (get-system-cb-list system))
        system
        (set-system
            (get-system-date system)
            (get-system-name system)
            (get-initial-cb-code-link system)
            (get-system-users system)
            (get-chat-history system)
            (append (get-system-cb-list system) (list chatbot))
        )
    )
))

; Descripcion: Funcion que actualiza el sistema.
; Dom: system-name (string) X system-date (string) X system-users (list) X chatbot-list (list)
; Rec: system (list)
; Recursion: -
(define set-system 
    (lambda (system-date system-name initial-cb-code-link system-users chat-history chatbot-list)
        (list system-date system-name initial-cb-code-link system-users chat-history chatbot-list)
))

; ######################################## EXPORTACION DE FUNCION ############################

(provide system system-add-chatbot)