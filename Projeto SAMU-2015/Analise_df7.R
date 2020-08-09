#libs
#install.packages("dplyr")
library("dplyr")
library("DT") #Utilizacao de tabelas
#Base 7 
perfil_viatura <- read.csv('Dados SAMU/viatura2015.csv',sep = ';')
unique(perfil_viatura$tipoviatura_descricao)
#Quantidade Total de Viaturas
length(perfil_viatura$tipoviatura_descricao)
#Contando o tipo de cada viatura
tipos_de_viatura <-unique(perfil_viatura$tipoviatura_descricao)
quantidade_por_viaturas <- data.frame()
for ( tipo in tipos_de_viatura) {
  total <-sum(perfil_viatura$tipoviatura_descricao==tipo)
  linha<- c(tipo,total)
  quantidade_por_viaturas <- rbind.data.frame(quantidade_por_viaturas, linha)
  
}
names(quantidade_por_viaturas) <- c('Tipo','Quantidade')
quantidade_por_viaturas$Quantidade <- as.numeric(quantidade_por_viaturas$Quantidade)


DT::datatable(quantidade_por_viaturas, rownames = FALSE, filter = "none",caption = "Quantidade de Viaturas")


#Gerando grafico pizza da distribuiçåo dos tipos de veiculos da frota do SAMU 2015
pcem <-round(quantidade_por_viaturas$Quantidade/sum(quantidade_por_viaturas$Quantidade)*100)
label_pcem <- paste(quantidade_por_viaturas$Tipo, pcem)
label_pcem <- paste(label_pcem,"%",sep="")
pie(main = "Grafico da distribuiçåo dos tipos de veiculos da frota do SAMU 2015",quantidade_por_viaturas$Quantidade,labels = label_pcem,col=rainbow(length(quantidade_por_viaturas$Quantidade)))
legend("topright",legend= quantidade_por_viaturas$Tipo,cex = 0.6, fill = rainbow(length(quantidade_por_viaturas$Quantidade)))











