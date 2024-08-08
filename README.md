# Resumo do Projeto

Este projeto é uma aplicação iOS desenvolvida em SwiftUI e integração com Firebase para autenticação de usuários. O aplicativo possui duas telas principais: a tela de login e a tela principal (HomeView), que exibe um menu lateral, um cronômetro regressivo e um QR Code gerado com base no UID do usuário.

## Pontos Principais

- **SwiftUI:** A interface do aplicativo é construída usando SwiftUI, uma moderna estrutura de desenvolvimento de interface de usuário da Apple, que permite a criação de interfaces de forma declarativa e altamente flexível.

- **Firebase Authentication:** Utilizamos o Firebase Authentication para autenticar usuários através de e-mail e senha. A autenticação é feita de forma assíncrona, permitindo que os usuários acessem a tela principal após o login bem-sucedido.

- **Firebase Firestore:** O Firestore é utilizado para armazenar os dados dos usuários e recuperar informações relevantes, como o UID do usuário, que é usado para gerar o QR Code na tela principal.

- **Menu Lateral:** Implementei um menu lateral na tela principal, que é acionado por um botão no canto superior esquerdo. O menu oferece opções como visualizar o QR Code, fazer reservas, associar empresa, ver detalhes da conta, entre outros.

- **Cronômetro Regressivo:** Adicionamos um cronômetro regressivo na tela principal, que conta regressivamente a partir de 60 segundos. Quando o tempo se esgota, uma ação pode ser acionada, como gerar um novo QR Code.




<img width="1440" alt="Captura de Tela 2024-03-14 às 10 49 11" src="https://github.com/victorbrigido/MyAccess/assets/110338761/48e00a07-63ec-4280-9ff8-b4023ad9587f">




## Usos do Aplicativo

- Este projeto pode ser utilizado como uma ferramenta de controle de acesso em eventos ou locais restritos, onde os usuários podem fazer login para obter um QR Code válido por um determinado período de tempo.

- Pode ser utilizado como parte de um sistema de reservas, onde os usuários podem fazer reservas através do aplicativo e obter um QR Code para acesso ao evento ou local reservado.

- Pode ser adaptado para ser usado como um sistema de autenticação em outros aplicativos, onde os usuários podem fazer login e obter um código QR como prova de autenticação para acesso a recursos ou funcionalidades específicas.




<img width="1440" alt="Captura de Tela 2024-03-14 às 10 49 26" src="https://github.com/victorbrigido/MyAccess/assets/110338761/d56519f5-b8b5-41fd-bf0f-969442d8d5ca">




<img width="1440" alt="Captura de Tela 2024-03-14 às 10 48 36" src="https://github.com/victorbrigido/MyAccess/assets/110338761/c458c010-b32a-4223-82d6-b30d51e2e6d0">
