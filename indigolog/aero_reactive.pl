
:- multifile proc/2.

proc(smart_calibrate_all, [
    if(neg(calibrated(s1)), calibrate(s1), []),
    if(neg(calibrated(s2)), calibrate(s2), []),
    if(neg(calibrated(s3)), calibrate(s3), [])
]).

/* REACTIVE CONTROLLER */
proc(control(reactive), prioritized_interrupts([

    /* 1. EMERGENZA BATTERIA (Priorità Alta) */
    interrupt(battery < 20, [
        say("BATTERY CRITICAL! Emergency Recharging..."), 
        recharge, 
        recharge
    ]),

    /* 2. GUASTI SENSORI (Exogenous Handling) */
    interrupt(some(s, and(activated(c), neg(calibrated(s)))), 
        pi(s, [
            ?(neg(calibrated(s))), 
            say("Sensor malfunction detected. Recalibrating..."), 
            calibrate(s)
        ])
    ),

    /* 3. PROGRESSIONE LOGICA */
    interrupt(neg(container_open), open_container),
    interrupt(neg(has_key), take_key),
    interrupt(neg(panel_open), open_panel),

    /* Gestione Interruttori Smart (Auto vs Manual) */
    interrupt(and(neg(activated(a)), battery > 40), activate_auto(a)),
    interrupt(and(neg(activated(a)), battery =< 40), [
        say("Low Battery: Manual Mode A"), 
        activate_manual(a)
    ]),

    interrupt(and(neg(activated(b)), battery > 40), activate_auto(b)),
    interrupt(and(neg(activated(b)), battery =< 40), [
        say("Low Battery: Manual Mode B"), 
        activate_manual(b)
    ]),

    interrupt(neg(activated(c)), activate_auto(c)),

    /* 4. CHIUSURA */
    interrupt(neg(exited), [smart_calibrate_all, exit]),
    interrupt(exited, [say("MISSION ACCOMPLISHED."), ?(false)])
])).