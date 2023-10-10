#lang racket

; ######################################## TDA USER ##########################################

; ######################################## REPRESENTACION ####################################

; Este TDA corresponde a un usuario.
; Dentro se guardara el nombre del usuario y un estado de actividad.

; ######################################## CONSTRUCTOR #######################################

; Descripcion: Funcion que genera un usuario.
; Dom: username (string) X user-status (boolean) X user-chat-history (list)
; Rec: user (list)
; Recursion: -
(define set-user (lambda (username user-status cb-code-link fl-code-link)
    (list username user-status cb-code-link fl-code-link)
))

; ######################################## PERTENENCIA #######################################

; Descripcion: Funcion que verifica si el username de un usuario ya existe en una lista de usuarios.
; Dom: username (list) X users-list (list)
; Rec: boolean
; Recursion: -
(define username-exists? (lambda (username users-list)
    (define aux (lambda (username users-list)
        (filter 
            ((lambda (username) (lambda (user) (if (string-ci=? username (get-username user)) #t #f))) 
            username) users-list
        )
    ))

    (if (null? (aux username users-list)) #f #t)
))

; Descripcion: Funcion que verifica si un usuario esta conectado.
; Dom: users-list
; Rec: boolean
; Recursion: -
(define someone-logged-in? (lambda (users-list)
    (define aux (lambda (users-list)
        (filter (lambda (user) (if (equal? #t (get-user-status user)) #t #f)) users-list)
    ))
    (if (null? (aux users-list)) #f #t)
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

; Descripcion: Funcion que obtiene el codigo del chatbot donde esta ubicado el usuario.
; Dom: user (list)
; Rec: cb-code-link (int)
; Recursion: -
(define get-cb-code-link (lambda (user)
    (list-ref user 2)
))

; Descripcion: Funcion que obtiene el codigo del flujo donde esta ubicado el usuario.
; Dom: user (list)
; Rec: fl-code-link (int)
; Recursion: -
(define get-fl-code-link (lambda (user)
    (list-ref user 3)
))

; Descripcion: Funcion que obtiene el usuario logueado en el sistema.
; Dom: users-list (list)
; Rec: user (list)
; Recursion: -
(define get-user-logged (lambda (users-list)
    (define aux (lambda (users-list)
        (filter (lambda (user) (if (equal? #t (get-user-status user)) #t #f)) users-list)
    ))

    (list-ref (aux users-list) 0)
))

; ######################################## MODIFICADOR #######################################

; Descripcion: Funcion que conecta a un usuario.
; Dom: username (string) X users-list (list)
; Rec: users-list (list)
; Recursion: -
(define login-user (lambda (username users-list)
    (map ((lambda (username) (lambda (user) 
        (if (string=? username (get-username user))
            (set-user username #t -1 -1)
            user
        )
    )) username) users-list)
))

; Descripcion: Funcion que desconecta a un usuario.
; Dom: users-list (list)
; Rec: users-list (list)
; Recursion: -
(define logout (lambda (users-list)
    (map (lambda (user) (set-user (get-username user) #f -1 -1)) users-list)
))

(define change-codelinks-in-user (lambda (users-list n-cb-code-link n-fl-code-link)
    (map 
        (lambda (user)
            (if (get-user-status user) 
                (set-user (get-username user) #t n-cb-code-link n-fl-code-link)
                user
            )
        )
        users-list
    )
))
; ######################################## EXPORTACION DE FUNCION ############################

(provide (all-defined-out))




