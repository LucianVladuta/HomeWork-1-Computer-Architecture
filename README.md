# HomeWork-1-Computer-Architecture
1. Decodificarea intrarilor
Am primit un semnal pe 15 biti pentru fiecare intrare X si Y pe care ulterior l-am decodificat.Cei 15 biti de intrare i-am impartit in 3 subgrupuri de biti:
De la dreapta la stanga, primii 7 biti I am stocat in x0, urmatorii 7 biti in x1 si ultimul bit(cel mai semfnificativ ) in x0.
Pentru primele 2 subgrupuri x0 si x1 am decodificat corespondentul acesteia in binar.Pentru fiecare cifra am luat cele 10 cazuri posibile (de la 0 la 9), primii 7 biti reprezentau cifra unitatilor si urmatorii 7 biti reprezentau cifra zecilor si le am scris in cod BCD in subgrupuri de cate 4 biti (de la stanga la dreapta, primii 4 biti reprezentand cifra zecilor si urmatorii 4 biti reprezentand cifra unitatilor).
Apoi am transfomat numarul din reprezentare BCD in reprezentare binara.
Din reprezentare binara am transformat numarul in complement fata de 2.In functie de bitul cel mai semnificativ la intrare initiala (bitul 15), am avut 2 cazuri posibile:
a)bitul este 0, deci numarul este pozitiv, iar scrierea in cod complement fata de 2 se face prin concatenarea lui 0 cu numarul scris in binar.
b)bitul este 1, deci numarul este negative, iar scrierea in cod complement fata de 2 se obtine prin scrierea semnalului in cod indirect(1 concatenat cu semnalul binar conjugat) adunat cu 1.
Astfel am obinut cele 2 semnale de intrare scrise fiecare intr un semnal cu semn pe 8 biti in complement fata de 2

2. Aplicarea algoritmului lui Booth
La intrare primim cele 2 semnale decodificate(cu semn pe 8 biti scrise in complement fata de 2);
Conform algoritmului vom avea cele 3 semnale A, S si P(produsul) fiecare avand lungimea de 17 biti(lungimea primului nr(nr1) + lungimea celui de al doilea nr(nr2) + 1).
Am initializat un m si un r(multiplicatorul) de aceeasi lungime cu a semnalelor de intrare(8 biti fiecare), am initializat un integer ‘i’ pentru a contoriza numarul de iteratii necesare aplicarii algoritmului si un reg cu semn pentru a stoca rezultatul final.
Am facut un bloc always ca la fiecare schimbare a semnalelor de intrare ‘nr1’ si ‘nr2’ se vor executa:
• Etapa de initializare unde ‘m’(multiplicatul) ia valoarea lui nr1 si ‘r’(multiplicatorul) ia valoarea lui nr2. ‘A’ se va scrie astfel: primii 8 biti reprezentand ‘m’, si restul de biti sunt initializati cu 0. ‘S’ se va scrie astfel:primii 8 biti reprezentand ‘-m’ si restul de biti sunt initializati cu 0.’P’ se va scrie astfel: primii 8(8 deoarece lungimea semnalului de intrare de 8) biti sunt initializati cu 0, apoi urmatorii 8 biti vor reprezenta ‘r’ si la final ultimul bit(cel mai putin semnificativ) se initializeaza cu 0;
• Se vor efectua 8 iteratii(deoarece 8 este lungimea multiplicatorului r)
• La fiecare iteratie se testeaza primii 2 biti ai lui P(bitul 0 si bitul 1) si in functie de caz se merge pe un anumit caz dupa care P se sifteaza cu 1
• In final se stocheaza in ‘rez’ bitul de semn din P (P[16]) concatenate cu cei mai putini biti semnificativi din P conform algoritmului
Iesirea ‘out’ ia valoarea ‘rez’;
