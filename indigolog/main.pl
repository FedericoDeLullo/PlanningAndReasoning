
/* 1. Caricamento Librerie */
:- dir(indigolog, F), consult(F).
:- dir(eval_bat, F), consult(F).

/* 2. Caricamento Progetto */
:- [aero_reasoning].
:- [aero_reactive].

/* 3. Configurazione Simulatore */
em_address(localhost, 8000).

load_devices([simulator]).

load_device(simulator, Host:Port, [pid(PID)]) :-
    dir(dev_simulator, File), 
    ARGS = ['-e', 'swipl', '-t', 'start', File, '--host', Host, '--port', Port],
    process_create(path(xterm), ARGS, [process(PID)]).

how_to_execute(Action, simulator, Action).

/* 4. Mapping Esogeno (Input -> Azione) */
translate_exog(leak, battery_leak).
translate_exog(jam1, jam_sensor(s1)).
translate_exog(jam2, jam_sensor(s2)).
translate_exog(jam3, jam_sensor(s3)).
translate_exog(ActionCode, Action) :- actionNum(Action, ActionCode), !.
translate_exog(A, A).
translate_sensing(_, SR, SR).

/* 5. Menu */
main :-
    findall(C, proc(control(C), _), LC),
    length(LC, N), repeat,
    nl, write('--- AERO CONTROLLERS & TASKS ---'), nl,
    forall((between(1, N, I), nth1(I, LC, C)), format('~d. ~w\n', [I, C])),
    nl, write('Select option (number): '), read(NC),
    (number(NC), nth1(NC, LC, C) ->
        (format('Executing: ~w\n', [C]), main(control(C)))
    ;
        write('Invalid selection.'), fail
    ).

main(C) :- indigolog(C).

:- set_option(log_level, 3).
:- set_option(wait_step, 1).