program BattagliaNavale;
uses
sysUtils;

type
arr = array [0..9,0..9] of string;
nave=array of Integer;

var
i,j,x,y,z,s,m,n,verso,cont:Integer;
sovrapposte:boolean;
griglia:arr;


//creo la griglia di gioco
procedure GrigliaGioco(range:Integer;var g:arr);
begin

 //popolo la griglia con '≈'
    for i:=0 to range do
    begin
        for j:=0 to range do
        begin
        g[i,j]:= '≈';
        end; 
    end;

end;


//Funzione che posiziona randomicamente le navi sulla griglia
procedure PosizioneNavi(navi:nave;griglia:arr;range:Integer);
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
                    griglia[x,(y+z)]:= sysUtils.intToStr(navi[i]);
                    //griglia[x,(y+z)]:='N'
                end
                else
                begin
                    griglia[(x+z),y]:= sysUtils.intToStr(navi[i]);
                    //griglia[(x+z),y]:='N'
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
    end
end;


procedure SparaColpo(x,y:Integer; griglia:arr);
begin
    if griglia[x,y] = '≈' then
    begin
        griglia[x,y]:= 'M';
        writeln('Mancata =( ');
    end
    else if griglia[x,y] = 'N' then
    begin
        griglia[x,y]:= 'X';
        writeln('Colpita !!! =) ');
    end
    else
    begin
        writeln('Hai già colpito questo punto');
    end;
end;


procedure DisegnaGriglia(griglia:arr);
begin
    for i:=0 to 9 do
    begin
        for j:=0 to 9 do
        begin
            write(griglia[i,j],' ');
        end;
        writeln();
    end
end;

//MAIN
begin
    randomize;
    GrigliaGioco(9,griglia);
    PosizioneNavi([5,3,2,3,5],griglia,9);
    
    repeat
        write('inserire la x: ');
        read(M);
        write('inserire la y: ');
        read(N);
        SparaColpo(m,n,griglia);
        DisegnaGriglia(griglia);

    until (True);
    
end.