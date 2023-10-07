#lang racket

; ######################################## LLAMADO DE TDA DATE ###############################

(require "TDA_date_20793038_SanhuezaVega.rkt")

; ######################################## TDA CHAT HISTORY ##################################

; ######################################## REPRESENTACION ####################################

; Este TDA corresponde a un historial de chat.
; Dentro se guardaran los datos de cada vez que un usuario interactuo correctamente
; con un chatbot.

; ######################################## CONSTRUCTOR #######################################

; Descripcion: Funcion que construye un registro a partir de la interaccion con un chatbot.
; Dom: username (string) X message (string)
; Rec: record (list)
; Recursion: -
(define set-record (lambda (username message)
    (string-append "Fecha: " (make-current-date) " Usuario: " username " Mensaje: " message)
))

; ######################################## MODIFICADOR #######################################

; Descripcion: Funcion que agrega un registro al chat history.
; Dom: ch-list (list) X username (string) X message (string)
; Rec: ch-list (list)
; Recursion: -
(define add-record-chat-history (lambda (ch-list username message)
    (append ch-list (list (set-record username message)))
))

; ######################################## EXPORTACION DE FUNCION ############################

(provide (all-defined-out))