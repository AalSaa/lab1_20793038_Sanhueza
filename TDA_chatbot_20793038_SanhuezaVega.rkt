#lang racket

; ######################################## LLAMADO DE TDA TOOLS ##############################

(require "TDA_tools_20793038_SanhuezaVega.rkt")

; ######################################## TDA CHATBOT #######################################

; ######################################## REPRESENTACION ####################################

; Este TDA corresponde a un chatbot.
; Dentro se guardara un id del chatbot, un nombre para el chatbot, un mensaje de bienvenida, 
; un id para un flow y una lista de opciones.

; ######################################## CONSTRUCTOR #######################################

; Descripcion: Funcion que construye un chatbot.
; Dom: id (int) X name (string) X welcomeMessage (string) X flows (list)
; Rec: chatbot (list)
; Recursion: -
(define chatbot (lambda (id name welcome-message start-flow-id  . flows)
    (set-chatbot id name welcome-message start-flow-id (add-elements-in-list flows null))
))

; Descripcion: Funcion que construye un chatbot.
; Dom: id (int) X chatbot-name (string) X welcome-message (string) 
;      X start-flow-id (int) X flow-list (list)
; Rec: chatbot (list)
; Recursion: -
(define set-chatbot (lambda (id chatbot-name welcome-message start-flow-id flow-list)
    (list id chatbot-name welcome-message start-flow-id flow-list)
))

; ######################################## SELECTOR ##########################################

; Descripcion: Funcion que obtiene el id del chatbot.
; Dom: chatbot (list)
; Rec: chatbot-id (int)
; Recursion: -
(define get-chatbot-id (lambda (chatbot)
    (list-ref chatbot 0)
))

; Descripcion: Funcion que obtiene el nombre del chatbot.
; Dom: chatbot (list)
; Rec: chatbot-name (string)
; Recursion: -
(define get-chatbot-name (lambda (chatbot)
    (list-ref chatbot 1)
))

; Descripcion: Funcion que obtiene el mensaje de bienvenida del chatbot.
; Dom: chatbot (list)
; Rec: welcome-message (string)
; Recursion: -
(define get-chatbot-welcome-message (lambda (chatbot)
    (list-ref chatbot 2)
))

(define get-chatbot-start-flow-id (lambda (chatbot)
    (list-ref chatbot 3)
))

; Descripcion: Funcion que obtiene la lista de flujos en el chatbot.
; Dom: chatbot (list)
; Rec: flow-list (list)
; Recursion: -
(define get-chatbot-fl-list (lambda (chatbot)
    (list-ref chatbot 4)
))

; ######################################## MODIFICADOR #######################################

; Descripcion: Funcion que añade un nuevo flujo al chatbot.
; Dom: chatbot (list) X flow (list)
; Rec: chatbot (list)
; Recursion: -
(define chatbot-add-flow (lambda (chatbot flow)
    (set-chatbot
        (get-chatbot-id chatbot)
        (get-chatbot-name chatbot)
        (get-chatbot-welcome-message chatbot)
        (get-chatbot-start-flow-id chatbot)
        (add-elements-in-list (list flow) (get-chatbot-fl-list chatbot))
    )
))

; ######################################## EXPORTACION DE FUNCION ############################

(provide (all-defined-out))