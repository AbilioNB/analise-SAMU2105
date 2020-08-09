install.packages("stringr")
library("stringr")

#Perfil dos distritos
dataset_distritos <- read.csv('Dados SAMU/distrito2015.csv',sep = ';',strip.white = T,na.strings = " ")


#Perfil Bairros
dataset_bairro <- read.csv('Dados SAMU/bairro2015.csv',sep = ';',strip.white = T,na.strings = " ")


#Jutando a localidade
base_localidade <- merge(x=dataset_distritos,y=dataset_bairro)



#Padronizando a coluna distritosanitario_descricao
base_localidade$distritosanitario_descricao <-str_to_upper(base_localidade$distritosanitario_descricao)

#unique(base_localidade$distritosanitario_descricao)

lista_de_municipios <- str_to_upper(unique(base_localidade$distritosanitario_descricao))
  
lista_de_municipios


#Criar a funcao

gerar_viaturas_por_municipio = function(nome_municipio){
  #Exemplificando com um municipio
  municipio <- subset(base_localidade,base_localidade$distritosanitario_descricao == nome_municipio)
  #Consigo saber qual o distrito sanitario da minha cidade, que engloba todos meus bairros de saude
  codigo_distrito <- unique(municipio$distritosanitario_codigo)
  #buscar agora a quantidade de veiculos dipostos a cidade 
  viaturas_saude <- subset(perfil_viatura,perfil_viatura$distritosanitario_codigo==codigo_distrito)
  cat('Temos um total de ',length(moreno_viaturas_saude$viatura_codigo),'viatura(s), com as seguintes especialidades:')
  for (tipoV in viaturas_saude$tipoviatura_descricao){
    print(tipoV)
  }
}






#Exemplificando com um municipio
moreno <- subset(base_localidade,base_localidade$distritosanitario_descricao == "CIDADE ITAMARACA")
#Consigo saber qual o distrito sanitario da minha cidade, que engloba todos meus bairros de saude
codigo_distrito_moreno <- unique(moreno$distritosanitario_codigo)
#Vamos buscar agora a quantidade de veiculos dipostos a cidade 
moreno_viaturas_saude <- subset(perfil_viatura,perfil_viatura$distritosanitario_codigo==codigo_distrito_moreno)
cat('Temos um total de ',length(moreno_viaturas_saude$viatura_codigo),'viatura(s), com as seguintes especialidades:')
for (tipoV in moreno_viaturas_saude$tipoviatura_descricao){
  print(tipoV)
}
#Vamos visualizar o atendimento de determinadas viaturas por cada bairro da cidade escolhida 
base_localidade_transporte <- merge(x=base_localidade,y=perfil_viatura)
moreno_bairros_tranposrte <- subset(base_localidade_transporte,base_localidade_transporte$distritosanitario_codigo==codigo_distrito_moreno)
View(moreno_bairros_tranposrte)



