Unit MainText;

interface

Const Nmax = 24;
max=3000;
Type
stat=record
nom:string;
freq:integer;
valeur:string;  //positive ou n‚gative
end; 
Tab = array[1..Nmax] of string;
tableau = array[1..max]of string;
tab1=array [1..max]of stat ;


procedure TextRead(name : string; var T:Tab); // read data from a text file and put it in an array
procedure TextWrite(name : string; T : tab);  // creates a text file in order to save the data of an array
procedure nombre_de_mot ( v:tab;var n:integer);//calculate the numbre of words in a ligne 
procedure rm(var v:string) ; //remove special caracters and space in a array of 1 ligne
procedure wc_w (var v:string;var n:integer); //calculate the numbre of word after appling 'rm_string' 
procedure extract_words (var t:tableau;ch :string;var n:integer); //extract words from a line of words
procedure od_freq(var t:tab1 ; n:integer) ;//ordon‚ par raport … la fr‚quence 'ordre d‚croissant'
procedure oc_freq(var t:tab1 ; n:integer) ;//ordon‚ par raport … la fr‚quence 'ordre croissant'
procedure o_alpha(var t:tab1 ; n:integer) ;//ordon‚ par ordre alphab‚tique les mot de nombre 'n' du tableau 't'
 procedure statistiques (var v:tableau;ch :string;var m:tab1;var x:integer ); //permet de class‚ les mot sans r‚p‚tition et avec son valeur et sa frequence dans un tableau d'enregistrement(m)
 
implementation

procedure TextRead(name : string; var T : tab);
var i: integer;
Fin : text;
begin

assign(Fin, name);
reset(Fin);

for i:=1 to Nmax do
    begin
        readln(Fin, T[i]);
        writeln('Reading line : ', i, 'from ', name);
    end;

close(Fin);
end;

procedure TextWrite(name : string; T : tab);
var i: integer;
Fout : text;

begin
assign(Fout, name);
Rewrite(Fout);

for i:=1 to Nmax do
    begin
        writeln(Fout, T[i]);
        writeln('Writing line : ', i, 'from ', name);
    end;

close(Fout);
end;


procedure nombre_de_mot (v:tab;var n:integer);
const sp=' ';
var s,i:integer;
chh :string;
begin

for i:=1 to Nmax do
    begin
    	n:=0;
    	chh:=v[i];
    	for s:=1 to length(v[i]) do
    	begin
    		if chh[s]=sp then
    		n:=n+1;
        end;
    	writeln ('le nombre de mot de la ligne ',i,' est : ',n);
    end;
end;    

procedure rm(var v:string) ;
 var new : string;
n,t : integer;   
begin 
	new:='';
	t:=0;
             for n:=1 to length(v) do
                            begin
                                if (((ord(v[n])>=65)and (ord(v[n])<=90))or((ord(v[n])>=97) and (ord(v[n])<=122))or(ord(v[n])=32)) then
                                begin
                                        t:=t+1;
                                         new:=new+v[n];
                                        if ((ord(new[t])=32 )and (ord(new[t-1])=32))then
                                        begin
                                        delete(new,t,1);
                                        t:=t-1;
                                        end;
                                 end;
                            end;   
                 v:=new   ;
end;

procedure wc_w (var v:string;var n:integer);
const sp=' ';
var s,i:integer;
begin
n:=0;
if v[length(v)]<>sp then
v:=v+sp;
    	for s:=1 to length(v) do
    	begin
    		if v[s]=sp then
    		n:=n+1;
        end;
    	writeln ('le nombre de mot de la ligne est',n);
    end;

procedure extract_words (var t:tableau;ch :string;var n :integer);
var i :integer;
mot : string;

begin
mot:='';
//n:=0;
for i:=1 to length(ch) do

  if (((ord(ch[i])>=65)and (ord(ch[i])<=90))or((ord(ch[i])>=97) and (ord(ch[i])<=122))) then
    begin
        mot:=mot+ch[i] ;
    end
  else 
     begin
        if ord(ch[i])=32 then
        n:=n+1 ;
        t[n]:=mot ;
        mot:='';
     //   writeln(t[n]);
	end;
end; 


procedure od_freq(var t:tab1 ; n:integer) ;//ordon‚ par raport … la fr‚quence 'ordre d‚croissant'
Var i,j,Min: integer ;
p:tab1;
begin
        for i :=1 to n - 1 do
        begin
                min := i ;
                for j:=i + 1 to n do
                begin
                        if t[j].freq > t[min].freq then
                        min:=j;
                end;
                if min <> i then
                begin
                        P[1] :=T[i];
                        T[i] := T[min];
                        T[min] := P[1];
                end;
        end;
end;

procedure oc_freq(var t:tab1 ; n:integer) ;//ordon‚ par raport … la fr‚quence 'ordre d‚croissant'
Var i,j,Min: integer ;
p:tab1;
begin
        for i :=1 to n - 1 do
        begin
                min := i ;
                for j:=i + 1 to n do
                begin
                        if t[j].freq <t[min].freq then
                        min:=j;
                end;
                if min <> i then
                begin
                        P[1] :=T[i];
                        T[i] := T[min];
                        T[min] := P[1];
                end;
        end;
end;


procedure o_alpha(var t:tab1 ; n:integer) ;//ordon‚ par ordre alphab‚tique
Var i,j,Min: integer ;
p:tab1;
begin
        for i :=1 to n - 1 do
        begin
                min := i ;
                for j:=i + 1 to n do
                begin
                        if t[j].nom < t[min].nom then
                        min:=j;
                end;
                if min <> i then
                begin
                        P[1] :=T[i];
                        T[i] := T[min];
                        T[min] := P[1];
                end;
        end;
end;


procedure statistiques (var v:tableau;ch :string;var m:tab1;var x:integer);//  ('ch' est la chain qui contain tous le mot puis ces mot ont va les class‚ dans 'v')  ('x' est le nombre des mots sans repetition)  ('m' un tableau qui contain tous les mot sans repetition)
var r,s,w,n,i :integer;
mot,sens : string;

begin
        mot:='';
        sens := copy (ch,length(ch)-7,length(ch));   //le nombre 8 est le nombre des caract‚re qui composant 'positive'ou 'negative' 
        n:=0;  // nombre des mots
        for i:=1 to length(ch) do
            begin
              if (((ord(ch[i])>=65)and (ord(ch[i])<=90))or((ord(ch[i])>=97) and (ord(ch[i])<=122))) then
                begin
                    mot:=mot+ch[i] ;
                end
              else 
                begin
                    if ord(ch[i])=32 then
                    n:=n+1 ;
                    v[n]:=mot ;
                    mot:='';
                end;
            end;
         w:= 0   ;
        for i:=1 to n do
        begin
            
                    r:=1;   // r est la frequence de mot
                   for s:=i+1to n do
                   begin
                        if v[i]<>'' then
                            begin
                                   if v[i]=v[s] then
                                    begin
                                       r:=r+1;
                                       v[s]:='';
                                   end;
                            end;
                   end;
                       if v[i]<>'' then
                               begin
                                   w:=w+1;
                                   m[w].freq:=r;
                               end;
        end;
        x:=0;
        for i:=1 to n do
        begin
                    if v[i] <>'' then
                    begin
                            x:=x+1;  //'x' est le nombre des mots sans repetition dans une chain de caract‚re
                            m[x].nom:=v[i];
                            m[x].valeur:=sens;
                    end;
        end;                
      //  writeln ('le nombre des mots sans repetition est :',x);
       { for i:=1to x do
        begin
            //    y:=y+1;
              // m[y]:=m[i]
         writeln('le nom est : ',m[i].nom);
            writeln('sa repetition est : ',m[i].freq);
            writeln('son sens : ',m[i].valeur);
            end;}
end; 


end.
