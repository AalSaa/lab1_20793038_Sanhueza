#lang racket

; ######################################## LLAMADO DE TDA´s ##################################

(require "TDA_date_20793038_SanhuezaVega.rkt")
(require "TDA_option_20793038_SanhuezaVega.rkt")
(require "TDA_flow_20793038_SanhuezaVega.rkt")
(require "TDA_chatbot_20793038_SanhuezaVega.rkt")
(require "TDA_user_20793038_SanhuezaVega.rkt")
(require "TDA_chathistory_20793038_SanhuezaVega.rkt")
(require "TDA_tools_20793038_SanhuezaVega.rkt")

; ######################################## TDA SYSTEM ########################################

; ######################################## REPRESENTACION ####################################

; Este TDA corresponde a un sistema.
; Dentro se guardara la fecha de creacion, el nombre del sistema, el id del primer chatbot a
; utilizar, una lista de usuarios, un historial del uso de los chatbots y una lista de
; chatbots.

; ######################################## CONSTRUCTOR #######################################

; Descripcion: Funcion que crea un sistema.
; Dom: name (string) X chatbot (list)
; Rec: system (list)
; Recursion: -
(define system (lambda (name start-cb-id . chatbot)
    (set-system
        (make-current-date)
        (string-downcase name)
        start-cb-id
        null
        null
        (add-elements-in-list chatbot null)
    )
))

; Descripcion: Funcion que construye un sistema.
; Dom: system-name (string) X system-date (string) X system-users (list) X chatbot-list (list)
; Rec: system (list)
; Recursion: -
(define set-system 
    (lambda (system-date system-name initial-cb-code-link system-users chat-history chatbot-list)
        (list system-date system-name initial-cb-code-link system-users chat-history chatbot-list)
))

; ######################################## PERTENENCIA #######################################
; Descripcion: Funcion que verifica si existe una opcion que contenga el id o mensaje indicado
;              en la carpeta actual usando funciones recursivas.
; Dom: system (list) X message (string)
; Rec: boolean
; Recursion: -
(define valid-message?-rec (lambda (system message)
    (if (not (boolean? (car (get-cb-and-fl-codelink system))))
        (option-exists-by-message?-rec (get-current-op-list system) message)
        #f
    )
))

; Descripcion: Funcion que verifica si existe una opcion que contenga el id o mensaje indicado
;              en la carpeta actual evitando funciones recursivas.
; Dom: system (list) X message (string)
; Rec: boolean
; Recursion: -
(define valid-message?-norec (lambda (system message)
    (if (not (boolean? (car (get-cb-and-fl-codelink system))))
        (option-exists-by-message?-norec (get-current-op-list system) message)
        #f
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

; Descripcion: Funcion que obtiene el id del chatbot inicial.
; Dom: system (list)
; Rec: initial-cb-code-link (int)
; Recursion: -
(define get-system-start-cb-id (lambda (system)
    (list-ref system 2)
))

; Descripcion: Funcion que obtiene la lista de usuarios del sistema.
; Dom: system (list)
; Rec: system-users (list)
; Recursion: -
(define get-system-users (lambda (system)
    (list-ref system 3)
))

; Descripcion: Funcion que obtiene el historial del chat.
; Dom: system (list)
; Rec: chat-history (list)
; Recursion: -
(define get-system-chat-history (lambda (system)
    (list-ref system 4)
))

; Descripcion: Funcion que obtiene la lista de opciones dentro del sistema.
; Dom: system (list)
; Rec: chatbot-list (list)
; Recursion: -
(define get-system-cb-list (lambda (system)
    (list-ref system 5)
))

; Descripcion: Funcion que obtiene los codelinks del chatbot y flujo actual.
; Dom: system (list)
; Rec: codelink-list (list)
; Recursion: -
(define get-cb-and-fl-codelink (lambda (system)
    (if (or (= -1 (get-cb-code-link (get-user-logged (get-system-users system))))
             (= -1 (get-fl-code-link (get-user-logged (get-system-users system)))))
        (get-initial-cb-and-fl-codelink system)
        (list (get-cb-code-link (get-user-logged (get-system-users system)))
              (get-fl-code-link (get-user-logged (get-system-users system))))
    )
))

; Descripcion: Funcion que obtiene los codelinks del chatbot y flujo iniciales dentro del sistema.
; Dom: system (list)
; Rec: codelink-list (list)
; Recursion: cola
(define get-initial-cb-and-fl-codelink (lambda (system)
    (define aux (lambda (element-list id n codelinks)
        (cond
        [(= n 2)
            (if (id-exists? (list id) element-list)
                (aux 
                    (get-chatbot-fl-list (get-element-by-id id element-list))
                    (get-chatbot-start-flow-id (get-element-by-id id element-list))
                    1
                    (list id)
                )
                (list #f #f)
            )
        ]
        [(= n 1)
            (if (id-exists? (list id) element-list)
                (append codelinks (list id))
                (list #f #f)
            )
        ]
        )
    ))
    (aux (get-system-cb-list system) (get-cb-code-link system) 2 null)
))

; Descripcion: Funcion que obtiene la lista de opciones actual del sistema.
; Dom: system (list)
; Rec: option-list (list)
; Recursion: -
(define get-current-op-list (lambda (system)
    (define aux (lambda (system codelinks)
        (get-flow-op-list
            (get-element-by-id (list-ref codelinks 1)
                (get-chatbot-fl-list 
                    (get-element-by-id (list-ref codelinks 0) (get-system-cb-list system)
    ))))))
    (aux system (get-cb-and-fl-codelink system))
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
            (get-system-start-cb-id system)
            (get-system-users system)
            (get-system-chat-history system)
            (append (get-system-cb-list system) (list chatbot))
        )
    )
))

; Descripcion: Funcion que añade un usuario al sistema.
; Dom: system (list) X username (list)
; Rec: system (list)
; Recursion: -
(define system-add-user (lambda (system username)
    (if (username-exists? (string-downcase username) (get-system-users system))
        system
        (set-system
            (get-system-date system)
            (get-system-name system)
            (get-system-start-cb-id system)
            (append (get-system-users system) (list (set-user (string-downcase username) #f -1 -1)))
            (get-system-chat-history system)
            (get-system-cb-list system)
        )
    )
))

; Descripcion: Funcion que loguea al usuario indicado en el sistema.
; Dom: system (list) X username (string)
; Rec: system (list)
; Recursion: -
(define system-login (lambda (system username)
    (if (not (someone-logged-in? (get-system-users system)))
        (set-system 
            (get-system-date system)
            (get-system-name system)
            (get-system-start-cb-id system)
            (login-user (string-downcase username) (get-system-users system))
            (get-system-chat-history system)
            (get-system-cb-list system)
        )
        system
    )
))

; Descripcion: Funcion que desloguea al usuario en el sistema.
; Dom: system (list)
; Rec: system (list)
; Recursion: -
(define system-logout (lambda (system)
    (set-system
        (get-system-date system)
        (get-system-name system)
        (get-system-start-cb-id system)
        (logout (get-system-users system))
        (get-system-chat-history system)
        (get-system-cb-list system)
    )
))

; Descripcion: Funcion que permite interactuar con el chatbot usando funciones recursivas.
; Dom: system (list) X message (string)
; Rec: system (list)
; Recursion: -
(define system-talk-rec (lambda (system message)
    (if (someone-logged-in? (get-system-users system))
        (if (valid-message?-rec system (string-downcase message))
            (set-system
                (get-system-date system)
                (get-system-name system)
                (get-system-start-cb-id system)
                (change-codelinks-in-user 
                    (get-system-users system)
                    (get-option-cb-codelink 
                        (get-option-by-message-rec 
                            (get-current-op-list system) 
                            (string-downcase message)))
                    (get-option-fl-codelink 
                        (get-option-by-message-rec 
                            (get-current-op-list system) 
                            (string-downcase message)))
                )            
                (add-record-chat-history 
                    (get-system-chat-history system)
                    (get-username (get-user-logged (get-system-users system)))
                    (string-downcase message)
                )
                (get-system-cb-list system)
            )
            system
        )
        system
    )
))

; Descripcion: Funcion que permite interactuar con el chatbot usando funciones no recursivas.
; Dom: system (list) X message (string)
; Rec: system (list)
; Recursion: -
(define system-talk-norec (lambda (system message)
    (if (someone-logged-in? (get-system-users system))
        (if (valid-message?-norec system (string-downcase message))
            (set-system
                (get-system-date system)
                (get-system-name system)
                (get-system-start-cb-id system)
                (change-codelinks-in-user 
                    (get-system-users system)
                    (get-option-cb-codelink 
                        (get-option-by-message-norec 
                            (get-current-op-list system) 
                            (string-downcase message)))
                    (get-option-fl-codelink 
                        (get-option-by-message-norec 
                            (get-current-op-list system) 
                            (string-downcase message)))
                )            
                (add-record-chat-history 
                    (get-system-chat-history system)
                    (get-username (get-user-logged (get-system-users system)))
                    (string-downcase message)
                )
                (get-system-cb-list system)
            )
            system
        )
        system
    )
))

; ######################################## EXPORTACION DE FUNCION ############################

(provide (all-defined-out))