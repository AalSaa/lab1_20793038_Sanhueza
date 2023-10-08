#lang racket

; ######################################## LLAMADO DE TDA´s ##################################

(require "TDA_option_20793038_SanhuezaVega.rkt")
(require "TDA_flow_20793038_SanhuezaVega.rkt")
(require "TDA_chatbot_20793038_SanhuezaVega.rkt")
(require "TDA_system_20793038_SanhuezaVega.rkt")

; ######################################## NOTA ##############################################

; El Script de prueba 1 se ha convertido en un bloque para no generar errores con el script 2
; para las nuevas pruebask, se usaran variables distintas a las del script 1 y 2.

; ######################################## SCRIPTS DE PRUEBA #################################

; Script de prueba 1:
#|
(define op1 (option 1 "1) Viajar" 2 1 "viajar" "turistear" "conocer"))
(define op2 (option 2 "2) Estudiar" 3 1 "estudiar" "aprender" "perfeccionarme"))
(define f10 (flow 1 "flujo1" op1 op2 op2 op2 op2 op1)) ;solo añade una ocurrencia de op2
(define f11 (flow-add-option f10 op1)) ;se intenta añadir opción duplicada
(define cb0 (chatbot 0 "Inicial" "Bienvenido\n¿Qué te gustaría hacer?" 1 f10 f10 f10 f10))  ;solo añade una ocurrencia de f10
(define s0 (system "Chatbots Paradigmas" 0 cb0 cb0 cb0))
(define s1 (system-add-chatbot s0 cb0)) ;igual a s0
(define s2 (system-add-user s1 "user1"))
(define s3 (system-add-user s2 "user2"))
(define s4 (system-add-user s3 "user2")) ;solo añade un ocurrencia de user2
(define s5 (system-add-user s4 "user3"))
(define s6 (system-login s5 "user8")) ;user8 no existe. No inicia sesión
(define s7 (system-login s6 "user1"))
(define s8 (system-login s7 "user2"))  ;no permite iniciar sesión a user2, pues user1 ya inició sesión
(define s9 (system-logout s8))
(define s10 (system-login s9 "user2")) |#

; Script de prueba 2:

;Chabot0
(define op1 (option  1 "1) Viajar" 1 1 "viajar" "turistear" "conocer"))
(define op2 (option  2 "2) Estudiar" 2 1 "estudiar" "aprender" "perfeccionarme"))
(define f10 (flow 1 "Flujo Principal Chatbot 1\nBienvenido\n¿Qué te gustaría hacer?" op1 op2 op2 op2 op2 op1)) ;solo añade una ocurrencia de op2 y op1
(define f11 (flow-add-option f10 op1)) ;se intenta añadir opción duplicada            
(define cb0 (chatbot 0 "Inicial" "Bienvenido\n¿Qué te gustaría hacer?" 1 f10 f10 f10 f10))  ;solo añade una ocurrencia de f10
;Chatbot1
(define op3 (option 1 "1) New York, USA" 1 2 "USA" "Estados Unidos" "New York"))
(define op4 (option 2 "2) París, Francia" 1 1 "Paris" "Eiffel"))
(define op5 (option 3 "3) Torres del Paine, Chile" 1 1 "Chile" "Torres" "Paine" "Torres Paine" "Torres del Paine"))
(define op6 (option 4 "4) Volver" 0 1 "Regresar" "Salir" "Volver"))
;Opciones segundo flujo Chatbot1
(define op7 (option 1 "1) Central Park" 1 2 "Central" "Park" "Central Park"))
(define op8 (option 2 "2) Museos" 1 2 "Museo"))
(define op9 (option 3 "3) Ningún otro atractivo" 1 3 "Museo"))
(define op10 (option 4 "4) Cambiar destino" 1 1 "Cambiar" "Volver" "Salir")) 
(define op11 (option 1 "1) Solo" 1 3 "Solo")) 
(define op12 (option 2 "2) En pareja" 1 3 "Pareja"))
(define op13 (option 3 "3) En familia" 1 3 "Familia"))
(define op14 (option 4 "4) Agregar más atractivos" 1 2 "Volver" "Atractivos"))
(define op15 (option 5 "5) En realidad quiero otro destino" 1 1 "Cambiar destino"))
(define f20 (flow 1 "Flujo 1 Chatbot1\n¿Dónde te Gustaría ir?" op3 op4 op5 op6))
(define f21 (flow 2 "Flujo 2 Chatbot1\n¿Qué atractivos te gustaría visitar?" op7 op8 op9 op10))
(define f22 (flow 3 "Flujo 3 Chatbot1\n¿Vas solo o acompañado?" op11 op12 op13 op14 op15))
(define cb1 (chatbot 1 "Agencia Viajes"  "Bienvenido\n¿Dónde quieres viajar?" 1 f20 f21 f22))
;Chatbot2
(define op16 (option 1 "1) Carrera Técnica" 2 1 "Técnica"))
(define op17 (option 2 "2) Postgrado" 2 1 "Doctorado" "Magister" "Postgrado"))
(define op18 (option 3 "3) Volver" 0 1 "Volver" "Salir" "Regresar"))
 
(define f30 (flow 1 "Flujo 1 Chatbot2\n¿Qué te gustaría estudiar?" op16 op17 op18))
(define cb2 (chatbot 2 "Orientador Académico"  "Bienvenido\n¿Qué te gustaría estudiar?" 1 f30))
;Sistema
(define s0 (system "Chatbots Paradigmas" 0 cb0 cb0 cb0 cb1 cb2))
(define s1 (system-add-chatbot s0 cb0)) ;igual a s0
(define s2 (system-add-user s1 "user1"))
(define s3 (system-add-user s2 "user2"))
(define s4 (system-add-user s3 "user2"))
(define s5 (system-add-user s4 "user3"))
(define s6 (system-login s5 "user8"))
(define s7 (system-login s6 "user1"))
(define s8 (system-login s7 "user2"))
(define s9 (system-logout s8))
(define s10 (system-login s9 "user2"))
;las siguientes interacciones deben funcionar de igual manera con system-talk-rec  o system-talk-norec 
(define s11 (system-talk-rec s10 "hola"))
(define s12 (system-talk-rec s11 "1"))
(define s13 (system-talk-rec s12 "1"))
(define s14 (system-talk-rec s13 "Museo"))
(define s15 (system-talk-rec s14 "1"))
(define s16 (system-talk-rec s15 "3"))
(define s17 (system-talk-rec s16 "5"))

; ######################################## PRUEBAS NUEVAS ####################################

; Se replicara un chatbot de compañia telefonia.

; Creacion de chatbot inicial (se intenta agregar varias veces la opcion op101 en el flujo)
(define op101 (option 1 "1) Equipos" 1 1 "Equipos" "TELEFONO" "celular")) ; option 1/3
(define op102 (option 1 "2) cambio de PLAN" 2 1 "cambio de PLAN" "plan" "cambio" "actualizar")) ; option 2/3
(define op103 (option 3 "3) ServiCIO tecniCo" 3 1 "ServiCIO tecniCo" "sercivio" "TECNICO")) ; option 3/3
(define op104 (option 4 "4) PORTABILIDAD" 4 1 "portar" "PORTABILIDAD")) ; option 4/3

(define f101 (flow 1 "Flujo 1 Chatbot0\n¿Qué te gustaría realizar?" op101 op101)) ; flow 1/3
(define f102 (flow-add-option f101 op101)) ; flow-add-option 1/3
(define f103 (flow-add-option f101 op102)) ; flow-add-option 2/3
(define f104 (flow-add-option f101 op103)) ; flow-add-option 3/3

(define cb101 (chatbot 0 "Inicial" "Bienvenido\n¿Qué te gustaría realizar?" 1 f101 f101 f101))  ; chatbot 1/3

; Creacion de chatbot para equipos (se intenta meter 2 veces el flujo f105 en el chatbot)
(define op105 (option 1 "1) Comprar" 1 2 "comprar" "obtener" "adquirir")) ; option 5/3
(define op106 (option 2 "2) renoVAR" 1 3 "cambiar" "actualizar" "renovar")) ; option 6/3
(define op107 (option 3 "3) Volver" 0 1 "volver" "retroceder" "inicio")) ; option 7/3

(define f105 (flow 1 "Flujo 1 Chatbot1\n¿Qué te gustaría solicitar?" op105 op106 op107)) ; flow 2/3

(define cb102 (chatbot 1 "EQUIPOS" "Bienvenido\n¿Qué te gustaría SOLICITAR?" 1))  ; chatbot 2/3
(define cb103 (chatbot-add-flow cb102 f105)) ; chatbot-add-flow 1/3
(define cb104 (chatbot-add-flow cb103 f105)) ; chatbot-add-flow 2/3

; Creacion de chatbot para cambio de plan (se intenta meter 2 veces la opcion op108 en el flujo)
(define op108 (option 1 "1) Plan mas economico" 2 2 "Plan mas economico" "economico" "barato" "basico")) ; option 8/3
(define op109 (option 2 "2) Plan mas avanzado" 2 3  "Plan mas avanzado" "avanzado" "mejorado" "mejor")) ; option 9/3
(define op110 (option 3 "3) vOLVER" 0 1 "volver" "retroceder" "INICIO")) ; option 10/3

(define f106 (flow 1 "Flujo 1 Chatbot2\n¿Qué PLAN te gustaría solicitar?" op108 op109 op108 op110)) ; flow 3/3

(define cb105 (chatbot 2 "CAMBIO DE PLAN" "Bienvenido\n¿Qué PLAN te gustaría SOLICITAR?" 1 f106))  ; chatbot 3/3

; Creacion de chatbot de servicio tecnico (se intenta meter varias veces el flujo f108)
(define op111 (option 1 "1) Solicitar reparacion por fallos" 3 2 "Solicitar reparacion por fallos" "fallos" "error" "FABRICA")) ; option 11/3
(define op112 (option 2 "2) Solicitar reparacion por daños" 3 3 "daños" "roto" "quebrado" "Solicitar reparacion por daños")) ; option 12/3
(define op113 (option 3 "3) vOLVER" 0 1 "volver" "retroceder" "INICIO")) ; option 13/3

(define f107 (flow 1 "Flujo 1 Chatbot2\n¿Qué REPARACION NECESITA?" op111 op112)) ; flow 4/3
(define f108 (flow-add-option f107 op113)) ; flow-add-option 3/3

(define cb106 (chatbot 3 "SERVICIO TECNICO" "Bienvenido\n¿Qué REPARACION NECESITA?" 1 f108 f108 f108)) ; chatbot 4/3

; Creacion de chatbot para portabilidad (se agregan las opciones en orden inverso)
(define op114 (option 1 "1) Portabilidad de otra compañia" 4 2 "OTRA" "DIFERENTE" "distinta" "Portabilidad de otra compañia")) ; option 14/3
(define op115 (option 2 "2) Portabilidad de esta misma compañia" 2 1 "Portabilidad de esta misma compañia" "MISMA" "IguaL" "ESTA")) ; option 15/3
(define op116 (option 3 "3) vOLVER" 0 1 "VOLVER" "retroceder" "inicio")) ; option 16/3

(define f109 (flow 1 "Flujo 1 Chatbot2\n¿Qué portabilidad desea solicitar?")) ; flow 5/3
(define f110 (flow-add-option f109 op116)) ; flow-add-option 4/3
(define f111 (flow-add-option f110 op115)) ; flow-add-option 5/3
(define f112 (flow-add-option f111 op114)) ; flow-add-option 6/3

(define cb107 (chatbot 4 "portabilidad" "Bienvenido\n¿Qué portabilidad necesita?" 1)) ; chatbot 5/3
(define cb108 (chatbot-add-flow cb107 f112)) ; chatbot-add-flow 3/3

; Creacion del sistema (s100, s101 y s107 son lo mismo)
(define s100 (system "telefonia" 0 cb101 cb104 cb105 cb106 cb108)) ; system 1/3

(define s101 (system "telefonica" 0 cb101 cb104 cb101 cb104 cb101 cb104 cb101 cb104 cb105 cb106 cb108)) ; system 2/3

(define s102 (system "telefonica" 0)) ; system 3/3
(define s103 (system-add-chatbot s102 cb101)) ; system-add-chatbot 1/3
(define s104 (system-add-chatbot s103 cb104)) ; system-add-chatbot 2/3
(define s105 (system-add-chatbot s104 cb105)) ; system-add-chatbot 3/3
(define s106 (system-add-chatbot s105 cb106)) ; system-add-chatbot 4/3
(define s107 (system-add-chatbot s106 cb108)) ; system-add-chatbot 5/3

; Agregar usuarios al sistema (se repite user1)

(define s108 (system-add-user s107 "USER1")) ; system-add-user 1/3
(define s109 (system-add-user s108 "user2")) ; system-add-user 2/3
(define s110 (system-add-user s109 "user1")) ; system-add-user 3/3

; Logear y desloguear usuarios en el sistema (user777 no existe y user1 no se puede loguear hasta desloguear user2)

(define s111 (system-login s110 "user777")) ; system-login 1/3
(define s112 (system-login s111 "user2")) ; system-login 2/3
(define s113 (system-login s112 "user1")) ; system-login 3/3
(define s114 (system-logout s113)) ; system-logout 1/3
(define s115 (system-login s114 "USER1")) ; system-login 4/3












