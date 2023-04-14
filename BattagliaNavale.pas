program BattagliaNavale;
uses
sysUtils;

type
arr = array [0..9,0..9] of string;
nave=array of Integer;

var
i,j,x,y,z,s,m,n,verso,cont:Integer;
sovrapposte:boolean;
griglia,g:arr;


//creo la griglia di gioco
function GrigliaGioco(range:Integer;var griglia:arr):arr;
begin

 //popolo la griglia con '≈'
    for i:=0 to range do
    begin
        for j:=0 to range do
        begin
        griglia[i,j]:= '≈';
        end; 
    end;
    GrigliaGioco:=griglia;
end;


//Funzione che posiziona randomicamente le navi sulla griglia
function PosizioneNavi(navi:nave;griglia:arr;range:Integer):arr;
begin

    for i:=0 to Length(navi) do
    begin
        
        sovrapposte:= true;
        while sovrapposte do
        begin
            cont:=0;
            x:=random(range+1);
            y:=random(range+1);
            verso:=random(2);
            //controllo posizionamento nave verticale
            if verso= 1 then
            begin
                for s:=0 to navi[i] do
                begin
                    if (((y+navi[i])>range) or (griglia[x,(y+s)] <> '≈')) then
                    begin
                        cont:=cont+1;
                    end
                end;
            end
            //controllo posizionamento nave orizzontale
            else
            begin
                for s:=0 to navi[i] do
                begin
                    if (((x+navi[i])> range) or (griglia[(x+s),y] <> '≈')) then
                    begin
                        cont:=cont+1;
                    end
                end;
            end;
            if cont = 0 then
            begin
                sovrapposte:=false;
            end;
        end;
        if sovrapposte=false then
        begin
            for z:=0 to (navi[i]-1) do
            begin
                if verso=1 then
                begin
                    //griglia[x,(y+z)]:= sysUtils.intToStr(navi[i]);
                    griglia[x,(y+z)]:='N'
                end
                else
                begin
                    //griglia[(x+z),y]:= sysUtils.intToStr(navi[i]);
                    griglia[(x+z),y]:='N'
                end;
            end;
        end;
    end;
    //Stampo la griglia
    for i:=0 to 9 do
    begin
        for j:=0 to 9 do
        begin
            write(griglia[i,j],' ');
        end;
        writeln();
        PosizioneNavi:=griglia;
    end
    
end;


function SparaColpo(x,y:Integer; griglia:arr):arr;
begin
    if griglia[y,x] = '≈' then
    begin
        griglia[y,x]:= 'M';
        writeln('Mancata =( ');
    end
    else if griglia[y,x] = 'N' then
    begin
        griglia[y,x]:= 'X';
        writeln('Colpita !!! =) ');
    end
    else
    begin
        writeln('Hai già colpito questo punto');
    end;
    SparaColpo:=griglia;
end;


function DisegnaGriglia(griglia:arr):arr;
begin
    for i:=0 to 9 do
    begin
        for j:=0 to 9 do
        begin
            write(griglia[i,j],' ');
        end;
        writeln();
    end;
    DisegnaGriglia:=griglia;
end;

//MAIN
begin
    randomize;
    g:=GrigliaGioco(9,griglia);
    g:=PosizioneNavi([5,3,2,3,5],griglia,9);
    
    while true do
    begin
        m:=0;
        n:=0;
        write('inserire la x: ');
        read(n);
        
        write('inserire la y: ');
        read(m);
        
        g:=SparaColpo(n,m,g);
        g:=DisegnaGriglia(g);
    end;
    
    
end.