%{
#include "Quad.h"	
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
extern  FILE  *yyin ;
int x; 
int sauvType ;
%}
%union{
int num;
int type;
char* ch;
struct{
int typ ;
char* res;
} com; 
}
%token <ch> idf sep1 sep2 sep3 sep4 sep5 sep6 sep7 sep8 sep10 sep11 sep12 ADD SUB ML DIV et <ch> MAIN <ch> CODE <ch> VERIF 
    <ch> AUTRE <ch> TANTQUE <ch> NATUAL <ch> FLOAT <ch> STRING  <ch> chainecar egale doubeg inf sup supeg infeg diff sep0 <ch> entier  
	<ch> reel_neg <ch> reel
	
    
   
%type <com>exp
%type <com>IDD
%left et
%left sup inf doubeg diff supeg infeg
%left ADD SUB
%left ML DIV

%%
S:MAIN sep1 Dec sep2 CODE sep1 INST sep2 {printf("\n programme syntaxiquement correct\n"); YYACCEPT;}
; 
Dec:ListIDF sep0 type sep5 Dec
ListIDF:Dec|ListIDF Dec
;
Dec:idf sep7 entier sep8 sep0 type sep5 Dec  {printf("une déclaration d un tableau %s \n",$1);}
				|ListIDF sep0 type sep5 Dec 				
;
valeur:entier |reel|sep3 reel_neg sep4
;
ListIDF:idf sep11 ListIDF|idf   			     		 
;
			
type:NATUAL {sauvType = 1;}
	|FLOAT  {sauvType = 2 ;}
	|STRING {sauvType= 3;}
	
;

INST:Affect sep5 INST|instVerif INST|instTantque INST|

;
Affect:idf egale exp  {if(nondeclar($1)==1) printf("Erreur semantique, non declaration de %s \n ", $1);


                     x= gettype($1); if((x==2)&&($3.typ!=2)) printf("Erreur semantique, incompatibilite de types");


                                    add_quad(":=",$3.res," ",$1);}

       

;
exp: exp SUB exp {if(($1.typ==2)||($3.typ==2)){
        
    	   printf("Erreur semantique, incompatibilite de types"); }  if($1.typ==3) $$.typ = 3; $$.typ = $3.typ;  
		   
		    $$.res = temp();
			add_quad("-",$1.res,$3.res,$$.res);
		   } 
    |exp ADD exp {if(($1.typ==2)||($3.typ==2)) {
        
    	   printf("Erreur semantique, incompatibilite de types");    }if($1.typ==3) $$.typ = 3; $$.typ = $3.typ;

            $$.res = temp();
			add_quad("+",$1.res,$3.res,$$.res);
		   }

    |exp DIV exp {if(($1.typ==2)||($3.typ==2)) {
        
    	   printf("Erreur semantique, incompatibilite de types");    } $$.typ=3; 

		   $$.res = temp();
		   add_quad("/",$1.res,$3.res,$$.res);

		   }
		   
	|exp ML exp {if(($1.typ==2)||($3.typ==2)) {
        
    	   printf("Erreur semantique, incompatibilite de types");    } if($1.typ==3) $$.typ = 3; $$.typ = $3.typ;
            
			$$.res = temp();
			add_quad("*",$1.res,$3.res,$$.res);

		   }
    | exp  inf exp   { $$.typ = 1 ; $$.res = temp(); $$.res = add_quadCond("BM",$1.res,$3.res); }
  
    
	| exp  sup exp  {$$.typ = 1 ; $$.res = temp(); $$.res = add_quadCond("BP",$1.res,$3.res);}
  
    
	| exp supeg exp {  $$.typ = 1 ; $$.res = temp(); $$.res = add_quadCond("BPZ",$1.res,$3.res); }
	
    
	| exp  egale exp {   $$.typ = 1 ;  $$.res = temp(); $$.res = add_quadCond("BZ",$1.res,$3.res);}
  
    
	| exp  diff exp {  $$.typ = 1 ; $$.res = temp(); $$.res = add_quadCond("BNZ",$1.res,$3.res);}
  
    
	| exp  infeg exp {  $$.typ = 1 ; $$.res = temp();  $$.res = add_quadCond("BMZ",$1.res,$3.res);}	   
    
	| exp  et exp  {  $$.typ = 1 ; $$.res = temp(); add_quadLogic(1,$1.res,$3.res,$$.res);}
		
	| IDD	
   
	   
IDD: idf { if(nondeclar($1)==1) printf("Erreur semantique, non declaration de %s \n ", $1); $$.typ= gettype($1);  $$.res=$1; }

    | idf sep7 entier sep8	 { if(nondeclar($1)==1) printf("Erreur semantique, non declaration de %s \n ", $1); $$.typ= gettype($1);  $$.res=$1; }
	
;

instVerif:VERIF sep3 exp sep4 sep7 INST sep8 AUTRE sep7 INST sep8 { if(nondeclar($3)==1) printf("Erreur semantique, non declaration de %s \n ", $3); } 
;

instTantque:TANTQUE sep3 Affect sep11 sep3 exp sep4 sep11 Affect sep4 sep7 INST sep8  { if(nondeclar($5)==1) printf("Erreur semantique, non declaration de %s \n ", $5); }
;
%% 
main () 
{ 
yyin = fopen("compil.txt","r");


initalis();
init_quad();
 
yyparse();

afficher();
Affich_quad();
}










  
		 
