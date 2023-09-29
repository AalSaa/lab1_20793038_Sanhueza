#lang racket

(require "TDA_option_20793038_SanhuezaVega.rkt")
(require "TDA_flow_20793038_SanhuezaVega.rkt")
(require "TDA_chatbot_20793038_SanhuezaVega.rkt")
(require "TDA_system_20793038_SanhuezaVega.rkt")

; Pruebas realizadas segun el script de prueba
(define op1 (option  1 "1) Viajar" 2 1 "viajar" "turistear" "conocer"))
(define op2 (option  2 "2) Estudiar" 3 1 "estudiar" "aprender" "perfeccionarme"))
(define f10 (flow 1 "flujo1" op1 op2 op2 op2 op2 op1)) ; solo añade una ocurrencia de op2
(define f11 (flow-add-option f10 op1)) ; se intenta añadir opción duplicada
(define cb0 (chatbot 0 "Inicial" "Bienvenido\n¿Qué te gustaría hacer?" 1 f10 f10 f10 f10)) ; solo añade una ocurrencia de f10
(define s0 (system "Chatbots Paradigmas" 0 cb0 cb0 cb0))
(define s1 (system-add-chatbot s0 cb0)) ;igual a s0

s1