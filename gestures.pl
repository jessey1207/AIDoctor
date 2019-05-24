/**
  * Knowledge base of Doctor's gestures.
  *
  * Three types of gestures.
  * The Doctor will pick a random gesture out of the gesture type depending on
    the mood and pain level of the patient.
  */

% gesture types
polite_gesture([look_attentive, mellow_voice, faint_smile, cross_legs]).
calming_gesture([broad_smile, joke, eye_contact, light_touch]).
normal_gesture([greet, look_concerned, look_composed, beaming_voice]).

% if patient is in no pain
make_gesture(no_pain, calm, X) :- normal_gesture(X).
make_gesture(no_pain, angry, X) :- calming_gesture(X).
make_gesture(no_pain, tired, X) :- polite_gesture(X).
make_gesture(no_pain, stressed, X) :- polite_gesture(X).
make_gesture(no_pain, frustrated, X) :- calming_gesture(X).

% if patient is in mild pain
make_gesture(mild_pain, calm, X) :- normal_gesture(X).
make_gesture(mild_pain, angry, X) :- calming_gesture(X).
make_gesture(mild_pain, tired, X) :- polite_gesture(X).
make_gesture(mild_pain, stressed, X) :- calming_gesture(X).
make_gesture(mild_pain, frustrated, X) :- calming_gesture(X).

% if patient is in manageable pain
make_gesture(manageable_pain, calm, X) :- normal_gesture(X).
make_gesture(manageable_pain, angry, X) :- calming_gesture(X).
make_gesture(manageable_pain, tired, X) :- polite_gesture(X).
make_gesture(manageable_pain, stressed, X) :- calming_gesture(X).
make_gesture(manageable_pain, frustrated, X) :- polite_gesture(X).

% if patient is in a lot of pain
make_gesture(lot_of_pain, calm, X) :- polite_gesture(X).
make_gesture(lot_of_pain, angry, X) :- calming_gesture(X).
make_gesture(lot_of_pain, tired, X) :- polite_gesture(X).
make_gesture(lot_of_pain, stressed, X) :- calming_gesture(X).
make_gesture(lot_of_pain, frustrated, X) :- calming_gesture(X).

% if patient is in unbearable pain
make_gesture(unbearable_pain, calm, X) :- polite_gesture(X).
make_gesture(unbearable_pain, angry, X) :- calming_gesture(X).
make_gesture(unbearable_pain, tired, X) :- polite_gesture(X).
make_gesture(unbearable_pain, stressed, X) :- calming_gesture(X).
make_gesture(unbearable_pain, frustrated, X) :- calming_gesture(X).

% by default, doctor will make a normal gesture
make_gesture(_,_,X) :- normal_gesture(X).
