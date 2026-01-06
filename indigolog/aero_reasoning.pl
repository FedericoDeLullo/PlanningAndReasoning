

:- multifile proc/2. 

/* --- GESTIONE MEMORIA (CACHE) --- */
:- dynamic cache/1.
cache(_) :- fail.

:- discontiguous fun_fluent/1, rel_fluent/1, proc/2, causes_true/3, causes_false/3, causes_val/4, prim_action/1, poss/2.

/* --- 1. DOMINIO --- */
switch(a). switch(b). switch(c).
sensor(s1). sensor(s2). sensor(s3).

/* FLUIDI RELAZIONALI */
rel_fluent(container_open). 
rel_fluent(has_key). 
rel_fluent(panel_open). 
rel_fluent(exited).
rel_fluent(activated(S)) :- switch(S).
rel_fluent(calibrated(S)) :- sensor(S).

/* FLUIDI FUNZIONALI */
fun_fluent(battery).
fun_fluent(time_left).

/* STATO INIZIALE */
initially(container_open, false). 
initially(has_key, false).
initially(panel_open, false). 
initially(activated(_), false).
initially(calibrated(_), false). 
initially(exited, false).
initially(time_left, 60).
initially(battery, 200). 

/* --- 2. AZIONI E CAUSE --- */

/* Effetti Relazionali */
causes_true(open_container, container_open, true).
causes_true(take_key, has_key, true).
causes_true(open_panel, panel_open, true).
causes_true(activate_auto(S), activated(S), true).
causes_true(activate_manual(S), activated(S), true).
causes_true(calibrate(S), calibrated(S), true).
causes_false(jam_sensor(S), calibrated(S), true).
causes_true(exit, exited, true).

/* Effetti Funzionali (Costi) */
causes_val(activate_auto(_), battery, B, B is battery - 15).
causes_val(activate_auto(_), time_left, T, T is time_left - 1).
causes_val(activate_manual(_), time_left, T, T is time_left - 10).
causes_val(open_container, time_left, T, T is time_left - 2).
causes_val(take_key, time_left, T, T is time_left - 1).
causes_val(open_panel, time_left, T, T is time_left - 3).
causes_val(calibrate(_), battery, B, B is battery - 10).
causes_val(calibrate(_), time_left, T, T is time_left - 5).
causes_val(recharge, battery, B, B is battery + 30).
causes_val(recharge, time_left, T, T is time_left - 10).
causes_val(battery_leak, battery, B, B is battery - 20).

/* Precondizioni */
prim_action(open_container). poss(open_container, neg(container_open)).
prim_action(take_key).       poss(take_key, and(container_open, neg(has_key))).
prim_action(open_panel).     poss(open_panel, and(has_key, neg(panel_open))).

prim_action(activate_auto(S)) :- switch(S).
poss(activate_auto(a), and(panel_open, and(neg(activated(a)), battery >= 15))).
poss(activate_auto(b), and(activated(a), and(neg(activated(b)), battery >= 15))).
poss(activate_auto(c), and(activated(b), and(neg(activated(c)), battery >= 15))).

prim_action(activate_manual(S)) :- switch(S).
poss(activate_manual(a), and(panel_open, neg(activated(a)))).
poss(activate_manual(b), and(activated(a), neg(activated(b)))).
poss(activate_manual(c), and(activated(b), neg(activated(c)))).

prim_action(calibrate(S)) :- sensor(S).
poss(calibrate(S), and(activated(c), and(neg(calibrated(S)), battery >= 10))).

prim_action(exit).
poss(exit, and(activated(a), and(activated(b), and(activated(c), 
           and(calibrated(s1), and(calibrated(s2), and(calibrated(s3), battery >= 5))))))).

prim_action(recharge). poss(recharge, battery < 100).
prim_action(say(_)).   poss(say(_), true).

/* Azioni Esogene */
exog_action(battery_leak). 
exog_action(jam_sensor(S)) :- sensor(S).
prim_action(Act) :- exog_action(Act). 
poss(Act, true) :- exog_action(Act).



/* --- REASONING TASK 1: LEGALITY --- */

proc(control(legality_success), [
    say("Testing LEGAL sequence..."),
    open_container, 
    take_key, 
    open_panel,
    say("Sequence finished correctly (LEGAL).")
]).

proc(control(legality_fail), [
    say("Testing ILLEGAL sequence (Expect Fail)..."),
    open_container,
    open_panel, 
    say("ERROR: This should not be reached.")
]).


/* --- REASONING TASK 2: PROJECTION --- */

proc(control(projection_true), [
    say("Testing Projection TRUE..."),
    open_container, take_key, open_panel, % Preparazione
    activate_auto(a),                     % Consumo 15 (200 -> 185)
    
    ?(battery > 150),                     % TEST: 185 > 150 -> VERO
    say("Projection Result: TRUE (Battery check passed).")
]).

proc(control(projection_false), [
    say("Testing Projection FALSE (Expect Fail)..."),
    open_container, take_key, open_panel,
    activate_auto(a),
    
    ?(battery > 195),                     % TEST: 185 > 195 -> FALSO -> FAIL
    say("ERROR: This should not be reached.")
]).



actionNum(X, X).