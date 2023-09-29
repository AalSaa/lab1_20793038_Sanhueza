#lang racket

; ######################################## LLAMADO DE RACKET/DATE ############################

(require racket/date)

; ######################################## TDA DATE ##########################################

; ######################################## REPRESENTACION ####################################

; Este TDA corresponde a una fecha.
; dentro de ella se incluye el dia, mes, año y hora.

; ######################################## CONSTRUCTOR #######################################

; Descripcion: Funcion que construye la fecha actual.
; Dom: null
; Rec: date (string)
; Recursion: -
(define make-current-date (lambda ()
    (string-append
        (get-current-day)
        "/"
        (get-current-month)
        "/"
        (get-current-year)
        " "
        (get-current-hour)
    )
))

; ######################################## SELECTOR ##########################################

; Descripcion: Funcion que obtiene el dia actual.
; Dom: null
; Rec: day (string)
; Recursion: -
(define get-current-day (lambda ()
    (number->string (date-day (current-date)))
))

; Descripcion: Funcion que obtiene el mes actual.
; Dom: null
; Rec: month (string)
; Recursion: -
(define get-current-month (lambda ()
    (number->string (date-month (current-date)))
))

; Descripcion: Funcion que obtiene el año actual.
; Dom: null
; Rec: year (string)
; Recursion: -
(define get-current-year (lambda ()
    (number->string (date-year (current-date)))
))

; Descripcion: Funcion que obtiene la hora actual.
; Dom: null
; Rec: hour (string)
; Recursion: -
(define get-current-hour (lambda ()
    (string-append
        (number->string (date-hour (current-date)))
        ":"
        (number->string (date-minute (current-date)))
        ":"
        (number->string (date-second (current-date)))
    )
))

; ######################################## EXPORTACION DE FUNCION ############################

(provide make-current-date)