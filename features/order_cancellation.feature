Feature: Cancelamento de Pedidos.
As um usuário. 
I want to acessar os pedidos em andamento e ter a possibilidade de solicitar o cancelamento de um pedido.
So that quando eu tiver algum contratempo ou mudar de ideia, eu possa cancelar o meu pedido.

Scenario: Cancelar pedido com status "Confirmado" e dentro do tempo limite (5 minutos).
Given eu estou logado como "Hugo" com senha "123".
And eu estou na página "Pedidos em Andamento". 
And o pedido "#01" foi realizado há "3" minutos.
And o status do pedido "#01" é "Confirmado".
When seleciona a opção "Cancelar Pedido" do pedido "#01". 
Then aparece a "Janela  de Confirmacao".

Scenario: Falha ao cancelar pedido após o tempo limite (5 minutos).
Given eu estou logado como "Cleber" com senha "123456#".
And eu estou na página "Pedidos em Andamento". 
And um usuário finalizou o pedido "#01" há "6" minutos.
And o status do pedido "#01" é "Confirmado".
When seleciona a opção "Cancelar Pedido". 
Then há uma "notificacao" informando "Tempo limite excedido!!".

Scenario: Falha ao cancelar pedido com status "em Preparo".
Given eu estou logado como "Luan" com senha "aeiou1357".
And eu estou na página "Pedidos em Andamento". 
And um usuário finalizou o pedido "#01" há "3" minutos.
And o status do pedido "#01" é "em Preparo".
When seleciona a opção "Cancelar Pedido". 
Then há uma "notificação" informando "Pedido ja em preparo :(".

Scenario: Falha na confirmação de cancelamento por senha incorreta.
Given eu estou logado como "Caio" com senha "vasco".
And eu estou na página "Pedidos em Andamento".
And eu estou com a "Janela de confirmacao" aberta.
When seleciona a opção "Outros".
And insiro a senha "321".
And seleciona a opção "Confirmar Cancelamento".
Then há uma "notificação" informando "Senha incorreta, tente novamente!".

Scenario: Falha no cancelamento por falta de preenchimento do campo "Motivo".
Given eu estou logado como "Emilly" com senha "aaabbbccc".
And eu estou na página "Pedidos em Andamento.
And eu estou com a "Janela de confirmação" aberta.
When insiro a senha "aaabbbccc".
And seleciona a opção "Confirmar Cancelamento".
Then há uma "notificação" informando "E necessario inserir um motivo para o cancelamento".

Scenario: Confirmação de cancelamento de pedido.
Given eu estou logado como "Thiagao" com senha "AVLC2001".
And eu estou na página "Pedidos em Andamento".
And eu estou com a "Janela de confirmacao" aberta.
When seleciona a opção "Outros".
And insiro a senha "AVLC2002".
And seleciona a opção "Confirmar Cancelamento".
Then há uma "notificacao" informando "Pedido Cancelado com sucesso!"

Scenario: Falha no cancelamento por falta de preenchimento do campo "Senha".
Given eu estou logado como "Otavio" com senha "googleMaps".
And eu estou na página "Pedidos em Andamento.
And eu estou com a "Janela de confirmação" aberta.
When seleciona a opção "Outros".
And seleciona a opção "Confirmar Cancelamento".
Then há uma "notificacao" informando "E necessario o preenchimento da senha".

Scenario: Voltar para página inicial.
Given eu estou logado como "Joao" com senha "senha".
And eu estou na página "Pedidos em Andamento". 
When seleciona a opção "Voltar". 
Then eu estou na página "Pagina Inicial".

Scenario: Cancelamento bem sucedido (serviço).
Given existe um usuário com id "3" e com senha "abretesesamo".
And um pedido com número "004" está registrado em "/users/3/orders".
When uma requisição de "POST" com id "3" e senha "abretesesamo" é enviada para "/users/"3"/orders/004/cancellation". 
Then o status da resposta deve ser "200". 
And uma mensagem de "Pedido cancelado" é retornada com id de pedido "004".

Scenario: Verificação Status do Pedido.
Given um pedido com número "002" está registrado no sistema de "Pedidos em andamento".
When uma requisição de "GET" é enviada para "Pedidos/002/Status".
Then o status da resposta deve ser "200".
And a resposta contém id "002" and nome "Status".

Scenario: Rota de acesso à página inicial a partir de "Pedidos em andamento".
Given o URL da página é "Pedidos em andamento".
And é solicitado o acesso à URL "Pagina Inicial".
When uma requisição de "GET" é enviada para "Paginas/PaginaInicial".
Then o status da resposta deve ser "200".
And o URL da página é "Pagina Inicial".

Scenario: Cancelamento mal sucedido (serviço).
Given eu estou logado como "Luis" com senha "#$%".
And um pedido com número "001" está registrado no sistema de "Pedidos em andamento".
When uma requisição de "DELETE" com login "Pedro" e senha "###" é enviada para "Pedidos/001".
Then o status da resposta deve ser "409".
And uma mensagem de "Pedido não cancelado" é retornada com id "001".

Scenario: Registro motivo cancelamento.
Given uma mensagem de "Pedido cancelado" é retornada com id "002".
When uma requisição de "POST" é enviada para "Pedidos/002/Motivo".
Then uma mensagem de "Justificativa salva" é retornada.
