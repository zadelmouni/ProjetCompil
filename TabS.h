
#define LENGTH 8

typedef struct element{
	char *nom;
	int code;
	int tailleEl;
	int typeEl;
	struct element *suit;
            }element;
			
			
element *tab[1000];

int fch(char *chaine)
{
    int i = 0, nombreHache = 0;

    for (i = 0 ; chaine[i] != '\0' ; i++)
    {
        nombreHache += chaine[i];
    }
    nombreHache %= 1000;

    return nombreHache;
}


int recherche(char *noml){

element *tete;
int index= fch(noml);	
if(tab[index]== NULL) return index;
else 
	tete = tab[index];
	
while(tete != NULL){
	if(strcmp(tete->nom, noml)==0) return -1;
	tete= tete->suit;
	}
	return index;
	}

	
void insert( char *idf,  int ncode,  int typeEll,  int ta  )
{
    int indi;    

    element *nodep = malloc(sizeof(element));
    nodep->nom = malloc(LENGTH + 1);

    strcpy(nodep->nom,idf);
    nodep->code = ncode ;
    nodep->typeEl = typeEll ;
	nodep->tailleEl = ta ;
    
   indi = fch(idf);

    if(tab[indi] == NULL){

    	tab[indi] = nodep;
	    nodep->suit = NULL;
    }
    else {
            if(strcmp(idf,tab[indi]->nom)!=0){
	    nodep->suit = tab[indi];
			tab[indi] = nodep; }
    }
  } 


