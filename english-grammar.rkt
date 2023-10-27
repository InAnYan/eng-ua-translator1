#lang amb-parser

S : NP VP;
NP : determiner? adjective* noun PP*;
VP : verb NP? PP*;
PP : preposition NP;
