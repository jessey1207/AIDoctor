/**
  * Core logic of the Sympathetic Doctor
  */

/* include necessary libraries */
:- ['diseases.pl', 'lists.pl', 'gestures.pl'].

is_yes(yes).

/* begin diagnosis for patient */
diagnose(Disease):-
  write('My favourite patient! Please take a seat so we can begin!\n'),
  /* create disease list for patient */
  patient_disease_list(Counter),
  /* decide which gesture to use */
  (ask_pain_level(P), ask_mood(M) -> make_gesture(P, M, G)),
  ask_patient('Are you feeling unwell somewhere?', Disease, G, Counter),
  print_list(['From your diagnosis, it is most likely you have: ', Disease, '.']).

/* identify pain level and mood of patient */
ask_pain_level(P):-
  write('How is your pain level? '),
  pain_library(PainList), member(P, PainList),
  print_list(['Are you in ', P, '? (yes/no)']),
  /* ask patient recursively if answer is not yes */
  read(R), is_yes(R), assert(pain(P)); ask_pain_level(P).
ask_mood(M):-
  write('How is your mood? '),
  mood_library(MoodList), member(M, MoodList),
  print_list(['Are you feeling ', M, '? (yes/no)']),
  /* ask patient recursively if answer is not yes */
  read(R), is_yes(R), assert(mood(M)); ask_mood(M).

/* generate gesture to question patient */
ask_patient(Question, Disease, Gestures, Counter):-
  ask_response(Question), ask_symptom(D, Gestures),
  /* if symptom observed, increment patient list */
  inc_patient_list(Counter, D, NewCounter),
  /* determine if diagnosis should be continued */
  ask_patient('Are you feeling unwell anywhere else?', Disease, Gestures, NewCounter);
  /* give diagnosis when no more symptoms */
  patient_diagnosis(Counter, Disease).

/* make sure patient gives valid response */
ask_response(Question):-
  print_list([Question, ' (yes/no)']), read(R), is_yes(R).

/* get random symptom to ask patient with appropriate gesture type */
ask_symptom(Disease, Gestures):-
  random_member(G, Gestures), get_random_symptom(Disease, Symptom),
  print_list(['Are you suffering from ', Symptom, '? *', G, '*' , ' (yes/no)']), read(R), is_yes(R),
  print_list(['Hmm, that is a symptom of ', Disease, '.']);
  ask_symptom(Disease, Gestures).
