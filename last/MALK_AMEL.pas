program INTELLIGENCE;
uses MainText;
//Const Nmax =24;
//Type  Tab = array[1..Nmax] of string;
type stat2=record
nom,valeur:string
end;
bgd =array[1..100]of stat2 ;

var v,v2:tab;
s,i:integer;
ch,ch2,bol,boll:string; //'boll'pour yes or no    'bol'pour freq
 m,new,tes,posi,nega: tab1;  //tableau d'enregistrement de 'stat'  
 r,t:tableau;
y,w,c,p,n,ndm,x:integer ;  //ndm =nombre des mots
help: stat;
 fin :bgd;
 p1,n1:integer;
begin
	c:=0;
	w:=0;
	p:=0;
	n:=0;
	Textread('DataText.txt',v) ;
	for i :=1 to 24 do
	begin
    rm(v[i]);
   end;
  // TextWrite('new2.txt',v);
 //nombre_de_mot(v,s);
 for s:=1 to 24 do
 begin
        statistiques(r,v[s],m,y); 
        for  i:=1 to y do
            begin
                c:=c+1;     //le nombre des mots dans les 24 ligne
                tes[c]:=m[i];  // tes un tableau de type (tab1)
            end;
end;

	for i:=1 to c do 
	begin
	writeln(tes[i].nom);
	writeln('sa frequence ',tes[i].freq);
	writeln('sa valeur ',tes[i].valeur)
	end;
	
	// remove repetition in 'tes'
	
	 for i:=1 to c do   //c= le nombre des mots totale dans 'tes' avec r‚p‚tition
        begin
        	help:=tes[i];
                   for s:=i+1to c do
                   begin
                        if help.nom<>'' then
                            begin
                                   if (help.nom=tes[s].nom)and(help.valeur=tes[s].valeur) then
                                    begin
                                       tes[i].freq:=tes[i].freq+tes[s].freq;
                                       tes[s].nom:='';
                                   end;
                                //else
                                if (help.nom=tes[s].nom)and(help.valeur<>tes[s].valeur) then
                                   begin                                                                                                                  //mais pour le test on va pas avoir des r‚sulatat comme on veut
                                  if tes[i].valeur<>tes[s].valeur then
                                   tes[i].nom:='';
                                   tes[s].nom:='';
                                   end;
                                   
                            end;
                   end;
                       if tes[i].nom<>'' then
                               begin
                                   w:=w+1;
                                   new[w]:=tes[i];
                               end;
        end;
{        x:=0;
        for i:=1 to n do
        begin
                    if v[i] <>'' then
                    begin
                            x:=x+1;  //'x' est le nombre des mots sans repetition
                            m[x].nom:=v[i];
                            m[x].valeur:=sens;
                    end;
        end;             }   
      
         o_alpha(new,w);
        
       for i:=1 to w do
        begin
        	writeln(new[i].nom);
        	writeln('sa frequence ',new[i].freq);
        	writeln('sa valeur ',new[i].valeur);
        end;
     
        for i:=1 to w do 
        begin
        	if (new[i].valeur='Positive') then
        	begin
                p:=p+1;
                posi[p]:=new[i];
        	end
            else
        	begin
        		if  (new[i].valeur='Negative') then
        		begin
                    n:=n+1;
                    nega[n]:=new[i];
                end;
        	end;
        end;
      
      
       writeln ('les mots positive sont :',p);
            for i:=1 to p do 
            begin
                writeln(posi[i].nom);
            end;
       writeln('les mots negative sont :',n);
            for i:=1 to n do 
            begin
                writeln(nega[i].nom);
            end;
 
 writeln ('entrez une chaine de caract‚re :');
 readln(ch);
 rm(ch);
 extract_words (t,ch,x);
 
 

for i:=1 to x do 
begin
fin[i].nom:=t[i];
fin[i].valeur:='neutre';
end;
for i:=1 to x do 
begin
        for s:=1 to w do
        begin
        	if fin[i].nom=new[s].nom then
        	fin[i].valeur:=new[s].valeur;
        end;
end;




p1:=0;n1:=0;
for i:=1 to x do
begin 
	if fin[i].valeur='Positive' then
	begin
            writeln ('positive : ',fin[i].nom);
            p1:=p1+1;
	end;
    if fin[i].valeur='Negative' then
    begin
            writeln ('negative : ',fin[i].nom);
            n1:=n1+1;
     end;
end;
writeln('p1 = ',p1,' n1 = ',n1);

if n1<p1 then
writeln('le message est positive');
if n1>p1 then 
writeln('le message est n‚gative ');

//partie qui permet a l utilisateur d afficher les mots de dictionnaire
repeat
writeln('esq voulez-vous afficher les mots de dictionnaire (YES/NO)');
readln(boll);
    if boll='YES' then
    begin 
        writeln('combien de de mots :');
        readln(s);
        
        writeln('type de l afficharge les afficher ordonn‚s par ordre alphab‚tique(alpha) des mots ou par ordre d‚croissant des fr‚quences(freq)');
                repeat
                       writeln('entrez le type de l afficharge (freq/alpha) ');
                       readln(bol);
                       if bol='alpha' then 
                       begin
                            o_alpha(new,w);
                            for i:=1 to s do 
                            begin
                            writeln('le mot ',new[i].nom,' sa fr‚quences ',new[i].freq);
                            end;
                        end;
                        
                         if bol='freq' then 
                       begin
                            od_freq(new,w);
                            for i:=1 to s do 
                            begin
                            writeln('le mot ',new[i].nom,' sa fr‚quences ',new[i].freq);
                            end;
                        end;
                until (bol='freq')or(bol='alpha')
        
    end;
    if boll='NO' then
    begin
        writeln('GoodBye') ;
    end;
until (boll='YES' )or (boll='NO' )
 
end.









