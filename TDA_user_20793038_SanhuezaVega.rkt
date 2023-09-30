#lang racket

; ######################################## TDA USER ##########################################

; ######################################## REPRESENTACION ####################################

; Este TDA corresponde a un usuario.
; Dentro se guardara el nombre del usuario y un estado de actividad.

; ######################################## PERTENENCIA #######################################

; Descripcion: Funcion que filtra a los usuarios que tengan el username indicado.
; Dom: username (string) X users-list (list)
; Rec: filtered-users-list (list)
; Recursion: -
(define has-same-username? (lambda (username users-list)
    (filter ((lambda (username) (lambda (user) (if (string-ci=? username (get-username user)) #t #f))) 
        username) users-list)
))

; Descripcion: Funcion que verifica si el username de un usuario ya existe en una lista de usuarios.
; Dom: username (list) X users-list (list)
; Rec: boolean
; Recursion: -
(define username-exists? (lambda (username users-list)
    (if (null? (has-same-username? username users-list)) #f #t)
))

; Descripcion: Funcion que filtra a los usuarios que esten conectados.
; Dom: users-list
; Rec: filtered-users-list
; Recursion: -
(define user-logged-in? (lambda (users-list)
    (filter (lambda (user) (if (equal? #t (get-user-status user)) #t #f)) users-list)
))

; Descripcion: Funcion que verifica si un usuario esta conectado.
; Dom: users-list
; Rec: boolean
; Recursion: -
(define someone-logged-in? (lambda (users-list)
    (if (null? (user-logged-in? users-list)) #f #t)
))

; ######################################## SELECTOR ##########################################

; Descripcion: Funcion que obtiene el nombre de usuario.
; Dom: user (list)
; Rec: username (string)
; Recursion: -
(define get-username (lambda (user)
    (list-ref user 0)
))

; Descripcion: Funcion que obtiene el estado de actividad del usuario.
; Dom: user (list)
; Rec: boolean
; Recursion: -
(define get-user-status (lambda (user)
    (list-ref user 1)
))

; ######################################## MODIFICADOR #######################################

; Descripcion: Funcion que genera un usuario.
; Dom: username (string) X user-status (boolean) X user-chat-history (list)
; Rec: user (list)
; Recursion: -
(define set-user (lambda (username user-status)
    (list username user-status)
))

; Descripcion: Funcion que conecta a un usuario.
; Dom: username (string) X users-list (list)
; Rec: users-list (list)
; Recursion: -
(define login-user (lambda (username users-list)
    (map ((lambda (username) (lambda (user) 
        (if (string-ci=? username (get-username user))
            (set-user username #t)
            user
        )
    )) username) users-list)
))

; ######################################## EXPORTACION DE FUNCION ############################

(provide username-exists? set-user someone-logged-in? login-user)




