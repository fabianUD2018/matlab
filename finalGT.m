
datos=readtable("gun-violence-data_01-2013_03-2018.csv");
whos datos
datos.state=categorical(datos.state);
datos.city_or_county=categorical(datos.city_or_county);
datos.incident_id=[];
datos.incident_url=[];
datos.incident_url_fields_missing=[];
datos.source_url=[];

datos.notes=[];
datos.state_house_district=[];
datos.sources=[];
datos.state_senate_district=[];
datos.congressional_district=[];
datos.participant_name=[];

whos datos
fig1=figure;
hist(datos.state)%%historico estados
title("Historico de incidentes por estado")
 xtickangle(90)

[n, nombre] = findgroups(datos.state);


sumKilled=splitapply(@sum,datos.n_killed, n);
 fig2=figure;%%historico de muertes por estado
 bar( nombre,sumKilled)
title("historico de muertes por estado")
 xtickangle(90)

% 
formatOut = 'yyyy';
str=datestr(datos.date,formatOut);
datos.year=[cellstr(str)];

[nY, anio] = findgroups(datos.year);
sumKilledYear=splitapply(@sum,datos.n_killed, nY );
fig3=figure%%muertes por año
bar( categorical(anio),sumKilledYear)

title("muertes en incidentes por año")
xtickangle(90)
fig4=figure;%%historico de incidentes por año
hist(categorical(datos.year))
title("incidentes por año")
temp1=strfind(datos.participant_gender,"Male" );
temp2=strfind(datos.participant_gender,"Female" );
 for i=1: length(datos.participant_gender)
   
   male(i)=length( temp1{i});
   female(i)=length( temp2{i});
 
 end

datos.nF=[female'];%%numero de mujeres en incidentes
datos.nM=[male'];%%numero de hombres en incidentes
clear temp1 temp2 male female
[nY, anio] = findgroups(datos.year);
sumFAnio=splitapply(@sum,datos.nF, nY );%%suma de mujeres por año
sumMAnio=splitapply(@sum,datos.nM, nY );%%suma de hombres por año
fig5=figure;%%participacion año mujeres
bar( categorical(anio),sumFAnio)
title("participacion por año mujeres")
xlabel('suma por año')
ylabel('años')


fig6=figure;%%participacion año hombres
bar( categorical(anio),sumMAnio)
title("participacion por año hombres")
xlabel('suma por año)')
ylabel('años')


fig7=figure;%%hombres vs mujers 
scatter(datos.nF,datos.nM)
title("participacion por año mujeres vs hombres")
 xlabel('participacion hombres')
  ylabel('participacion mujeres')
sumaMujeres= sum(datos.nF);
sumaHombres= sum(datos.nM);


fig8=figure;%%porcentaje de hombre vs mujeres
pie([sumaHombres, sumaMujeres])
title("participacion hombres vs mujeres")
tempA=strfind(datos.participant_age_group,"Adult" );
tempT=strfind(datos.participant_age_group,"Teen" );
tempC=strfind(datos.participant_age_group,"Child" );

 for i=1: length(datos.participant_gender)
   
   Adultos(i)=length( tempA{i});
   Jovenes(i)=length( tempT{i});
   Infantes(i)=length( tempC{i});
 
 end

datos.nAd=[Adultos'];%%numero de Adultos en incidentes
datos.nT=[Jovenes'];%%numero de adolecentes en incidentes
datos.nC=[Infantes'];%%numero de niños en incidentes

clearvars Adultos Jovenes Infantes tempA tempT tempC 


fig9= figure;%%porcentaje de aprticipacion aductos, niños,adolecentes
pie([sum(datos.nAd), sum(datos.nT),sum(datos.nC)])
title("participacion por adultos, niños, adolescentes")
labels={"porcentaje de adultos", "porcentaje de adolecentes", "porcentaje de niños"};
legend(labels,'Location','southoutside','Orientation','horizontal')


%comenzamos extraccion de datos de la relacion de la participantes en el
%incidente

tempF=strfind(datos.participant_relationship,"Family" );
tempG=strfind(datos.participant_relationship,"Gang vs Gang" );
tempR=strfind(datos.participant_relationship,"Robbery" );
tempSO=strfind(datos.participant_relationship,"Significant others" );
tempMS=strfind(datos.participant_relationship,"Mass shooting" );
tempAq=strfind(datos.participant_relationship,"Aquaintance" );
tempCW=strfind(datos.participant_relationship,"Co-worker" );
tempNe=strfind(datos.participant_relationship,"Neighbor" );
tempFri=strfind(datos.participant_relationship,"Friends" );
tempInv=strfind(datos.participant_relationship,"Invasion" );
 for i=1: length(datos.participant_gender)
     
     family(i)=length( tempF{i});
     gang(i)=length( tempG{i});
     robery(i)=length( tempR{i});
     so(i)=length( tempSO{i});
     MS(i)=length( tempMS{i});
     aq(i)=length( tempAq{i});
     cw(i)=length( tempCW{i});
     ne(i)=length( tempNe{i});
     fri(i)=length( tempFri{i});
     inv(i)=length( tempInv{i});
 
 end
 
 datos.family=[family'];
 datos.gang=[gang'];
 datos.robery=[robery'];
 datos.others=[so'];
 datos.mass=[MS'];
 datos.aq=[aq'];
 datos.cw=[cw'];
 datos.ne=[ne'];
 datos.fri=[fri'];
 datos.inv=[inv'];
 clearvars tempF tempG tempR tempSO tempMS tempAq tempCW tempNe tempFri tempInv
 clearvars family gang robery so MS aq cw ne fri inv 
 fig10 = figure;%%bar plot de los tupos de incidentes 
  tiposP=[sum(datos.family),sum(datos.gang), sum(datos.robery), sum(datos.others), sum(datos.mass), sum(datos.aq), sum(datos.cw), sum(datos.ne), sum(datos.fri), sum(datos.inv) ];
  
  bar(categorical(["familiar","pandillas","robo", "otros", "tiroteo masivo", "conocido", "Comp trabajo", "vecino", "amigo", "invasion"]),tiposP )
  title("participacion por tipo de incidente")
  
  fig11= figure;%%pie de los tpos de incidentes
pie(tiposP)
title("porcentaje de participacion por tipo de incidente")
labels={"familiar","pandillas","robo", "otros", "tiroteo masivo", "conocido", "Comp trabajo", "vecino", "amigo", "invasion"};
legend(labels,'Location','southoutside','Orientation','horizontal')

