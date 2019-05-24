/**
  * Knowledge base of diseases recognised by Doctor.
  *
  * Five diseases, each with five syptoms.
  */

/* for list manipulation */
:- ['lists.pl'].

/* disease library */
diseases([cancer, anemia, adhd, type_2_diabetes, dengue_fever]).

/* symptoms library */
cancer([blood_in_urine, blood_tinged_saliva, diarrhoea, difficulty_swallowing, persistent_lumps]).
anemia([fatigue, insomnia, leg_cramps, shortness_of_breath, dizziness]).
adhd([dificult_concentrating, frequent_mood_swings, stress, impulsiveness, restlessness]).
type_2_diabetes([dry_mouth, frequent_urination, blurred_vision, increased_hunger, muscle_weakness]).
dengue_fever([muscle_pain, skin_rashes, constant_nausea, severe_abdominal_pain, bleeding_gums]).

/* pain library */
pain_library([no_pain, mild_pain, manageable_pain, lot_of_pain, unbearable_pain]).

/* mood library */
mood_library([calm, angry, tired, stressed, frustrated]).


/* get random symptom to ask patient */
get_random_symptom(X,Y) :- random_disease(X), random_symptom(X,Y).
/* get the random symptom from random disease */
random_disease(X) :- diseases(L), random_member(X,L).
random_symptom(cancer, X) :- cancer(L), random_member(X,L).
random_symptom(anemia, X) :- anemia(L), random_member(X,L).
random_symptom(adhd, X) :- adhd(L), random_member(X,L).
random_symptom(type_2_diabetes, X) :- type_2_diabetes(L), random_member(X,L).
random_symptom(dengue_fever, X) :- dengue_fever(L), random_member(X,L).

/* create list for new patient */
/* list length is equal to length of disease list and has initial values of */
patient_disease_list(PatientList) :- diseases(D), list_length(D, Listlen),
  length(PatientList, Listlen), maplist(=(0), PatientList).

/* increment a disease counter in the patient list */
inc_patient_list(PatientList, Disease, Res) :-
  diseases(D), indexOf(Disease, D, Index), increment_disease(Index, PatientList, Res).

/* disease with highest count in patient list is the diagnosed disease */
patient_diagnosis(PatientList, Disease) :- list_max(PatientList, Max, Index),
  Max>0, diseases(D), nth0(Index, D, Disease);
  Disease = no_disease.
