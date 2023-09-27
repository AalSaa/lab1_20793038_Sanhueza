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
    (list id message chatbot-codelink flow-codelink keyword)
))

; ######################################## EXPORTACION DE FUNCION ############################

(provide option)