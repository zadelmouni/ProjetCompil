%{
#include "TabS.h" 
#include "syntaxe.tab.h"
extern YYSTYPE yylval;
int nligne=0;
int ncolone;

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

void initalis(){
int k=0;

while(k<100){

	tab[k]= NULL; k++;
	
} 
}


int gettype(char *ch){

int ind = fch(ch);

int type;

element * tete ;

tete = tab[ind];

while(tete!=NULL) 
{
if(strcmp(tete->nom,ch)==0){
type = tete-> typeEl ;
return type;
}
tete->suit;
}

}



int doubledec(char *entite){

int reponse= recherche(entite);
if(reponse == -1) 
{
int pos = fch(entite);
if(tab[pos]->typeEl == -1) return 1;
else return 0;
}
}


int nondeclar(char *nom){

int ind= fch(nom) ;
element *tete = tab[ind];
while(tete!=NULL){
if(strcmp(tete->nom,nom)==0) if(tete->typeEl == -1) return 1;
tete=tete->suit;
} 
}



void insererType( char entite[], int type)
{
int pos = fch(entite);
tab[pos]->typeEl = type;
}

void insererTaille( char entite[], int taille){
int pos = fch(entite);
tab[pos]->tailleEl = taille;
}

void afficher (){
printf("**********Table des Symboles**********\n");
printf("________________________________________________________________\n");
printf("\t| NOM   |  Nature |  Type |  Taille |\n");
printf("_________________________________________________________________\n");
int i= 0;
element *tete;
while(i<1000){
if(tab[i]!= NULL){
tete= tab[i];
while(tete != NULL){
printf("\t|%6s |%8d |%6d |%8d | \t|\n",tete->nom,tete->code, tete->typeEl, tete->tailleEl);
tete= tete->suit;
}
}
i++;
}

}

%}
commentaire "$".*
chainecar "'"([a-zA-Z0-9]?)*"'" 
idf [a-z]+
entier [1-9][0-9]*|0
reel {entier}"."[0-9]+
reel_neg [-]{entier}"."[0-9]+

MAIN "MAIN"
CODE "CODE"
NATUAL "NATUAL"
FLOAT "FLOAT"
STRING "STRING"
VERIF "VERIF"
AUTRE "AUTRE"
TANTQUE "TANTQUE"
sep0 ":"
sep1 "{"
sep2 "}"
sep3 "("
sep4 ")"
sep5 ";"
sep6 "|"
sep7 "["
sep8 "]"
egale "="
doubeg "=="
sep10 [ \t]
sep11 ","
sep12 "."
inf "<"
sup ">"      
supeg ">="
infeg "<="
diff "!="
ADD "+"
DIV "/"
SUB "-"
ML "*"
et   "&"	 			


%%
stop yyterminate();
{idf} {if(yyleng<=8){printf(" %s \n",yytext); ncolone += strlen(yytext); yylval.ch=strdup(yytext); insert( yytext , 1 , -1 ,0); return idf;}
                 else {printf(" erreur lexical idf trop long a la ligne %d, colone %d ",nligne,ncolone);}};
				 
		 
{entier} {if(atoi(yytext)<=32767 &&  atoi(yytext)>=0){printf(" %s \n",yytext); ncolone += strlen(yytext); yylval.ch=strdup(yytext);}
             else {printf(" erreur lexical entier depasse l intervalle a la ligne %d, colone %d ",nligne,ncolone);}};
	 		 
{commentaire} {printf("$ ceci est un commentaire ");};
{MAIN}        {printf(" %s",yytext); ncolone += strlen(yytext); return MAIN;};
{CODE}        {printf(" %s",yytext); ncolone += strlen(yytext); return CODE;};
{NATUAL}      {printf(" %s",yytext); ncolone += strlen(yytext); return NATUAL;};
{FLOAT}       {printf(" %s",yytext); ncolone += strlen(yytext); return FLOAT;};
{STRING}      {printf(" %s",yytext); ncolone += strlen(yytext); return STRING;};
{VERIF}       {printf(" %s",yytext);  ncolone += strlen(yytext); return VERIF;};
{AUTRE}       {printf(" %s",yytext); ncolone += strlen(yytext); return AUTRE;};
{TANTQUE}     {printf(" %s",yytext); ncolone += strlen(yytext); return TANTQUE;};
{sep0}        {printf(" %s",yytext); ncolone += strlen(yytext); return sep0;};
{sep1}        {printf(" %s",yytext); ncolone += strlen(yytext); return sep1;};
{sep2}        {printf(" %s",yytext); ncolone += strlen(yytext); return sep2;};
{sep3}        {printf(" %s",yytext); ncolone += strlen(yytext); return sep3;};
{sep4}        {printf(" %s",yytext); ncolone += strlen(yytext); return sep4;};
{sep5}        {printf("%s ",yytext); ncolone += strlen(yytext); return sep5;};
{sep6}        {printf("%s ",yytext); ncolone += strlen(yytext); return sep6;};
{sep7}        {printf("%s ",yytext); ncolone += strlen(yytext); return sep7;};
{sep8}        {printf("%s ",yytext); ncolone += strlen(yytext); return sep8;};
{egale}       {printf("%s ",yytext); ncolone += strlen(yytext); return egale;};
{doubeg}       {printf("%s ",yytext); ncolone += strlen(yytext); return doubeg;};
{sep10}       {printf("%s",yytext); ncolone += 4;};
{sep11}       {printf("%s ",yytext); ncolone += strlen(yytext); return sep11;};
{sep12}       {printf("%s ",yytext); ncolone += strlen(yytext); return sep12;};
{inf}         {printf("%s ",yytext); ncolone += strlen(yytext); return inf;};
{sup}         {printf("%s ",yytext); ncolone += strlen(yytext); return sup;};
{supeg}       {printf("%s ",yytext); ncolone += strlen(yytext); return supeg;};
{infeg}       {printf("%s ",yytext); ncolone += strlen(yytext); return infeg;};
{diff}        {printf("%s ",yytext); ncolone += strlen(yytext); return diff;};
{ADD}         {printf("%s ",yytext); ncolone += strlen(yytext); return ADD;};
{DIV}         {printf("%s ",yytext); ncolone += strlen(yytext); return DIV;};
{SUB}         {printf("%s ",yytext); ncolone += strlen(yytext); return SUB;};
{ML}          {printf("%s ",yytext); ncolone += strlen(yytext); return ML;};
{et}          {printf("%s ",yytext); ncolone += strlen(yytext); return et;};

{chainecar}   {printf("%s",yytext); ncolone += strlen(yytext); yylval.ch =strdup(yytext); return chainecar;};
{reel}        {printf("%s \n",yytext); ncolone += strlen(yytext); yylval.ch =strdup(yytext); return reel;}; 
{reel_neg}    {printf("%s \n",yytext); ncolone += strlen(yytext); yylval.ch =strdup(yytext); return reel_neg;};
"\n"          {printf("\n"); nligne++;ncolone=1;};
" \t"         {printf("%s\n ",yytext);};
. {printf("Erreur lexical a la ligne %d, colone %d\n",nligne,ncolone);};

