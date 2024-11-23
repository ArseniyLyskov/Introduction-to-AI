/*
 * Logical puzzle.
 *
 * Butsie is a brown cat, Cornie is a black cat, Mac is a red cat.
 * Flash, Rover and Spot are dogs. Flash is a spotted dog, Rover
 * is a red dog and Spot is a white dog. Fluffy is a black dog.
 *
 * Tom owns any pet that is either brown or black. Kate owns all
 * non-white dogs, not belonging to Tom.
 *
 * All pets Kate or Tom owns are pedigree animals.
 *
 * Alan owns Mac if Kate does not own Butsie and Spot is not a pedigree
 * animal.
 *
 * Write a Prolog program that answers, which animals do not have an owner.
*/

animal(butsie, cat, brown).
animal(cornie, cat, black).
animal(mac, cat, red).
animal(flash, dog, spotted).
animal(rover, dog, red).
animal(spot, dog, white).
animal(fluffy, dog, black).

owns(tom, Animal) :-
    animal(Animal, _, brown);
    animal(Animal, _, black).

owns(kate, Animal) :-
    animal(Animal, dog, _),
    \+ owns(tom, Animal),
    \+ animal(Animal, _, white).

pedigree(Animal) :-
    owns(tom, Animal);
    owns(kate, Animal).

owns(alan, mac) :-
    \+ owns(kate, butsie),
    \+ pedigree(spot).

no_owner(Animal) :-
    animal(Animal, _, _),
    \+ owns(tom, Animal),
    \+ owns(kate, Animal),
    \+ owns(alan, Animal).
