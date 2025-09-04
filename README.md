# 📌 Descrição Geral — Projeto VoltRoute

O **VoltRoute** é um aplicativo mobile desenvolvido em **Flutter**, voltado para **donos de carros 100% elétricos** que desejam planejar viagens de forma prática e confiável. A proposta é oferecer ao usuário um **planejador inteligente de rotas**, que considera não apenas o ponto de partida e o destino, mas também a **necessidade de recargas no trajeto**, levando em conta as características específicas do veículo.

---

## 🎯 Objetivo

Permitir que motoristas de veículos elétricos planejem viagens seguras, com previsão de **paradas para recarga**, cálculo do **estado da bateria (SoC)** ao chegar em cada ponto e estimativa de **tempo de carregamento** em cada estação.

---

## 👤 Público-alvo

* Motoristas entre **35 e 60 anos**.
* Proprietários de veículos elétricos de marcas como Tesla, Volvo, BYD, entre outras.
* Usuários que valorizam **simplicidade, confiabilidade e clareza visual**.

---

## ⚡ Funcionalidades principais

1. **Planejamento de rotas**: inserir origem e destino, selecionar veículo e visualizar percurso.
2. **Paradas automáticas**: sugestão de postos de recarga no caminho, compatíveis com o veículo.
3. **Integração com Google Places API**: busca de postos do tipo `electric_vehicle_charging_station`.
4. **Estimativas inteligentes**: cálculo de bateria restante ao chegar no ponto de carga, tempo de viagem, consumo de energia.
5. **Modos de uso**:

   * **Viagem rápida (sem login)**.
   * **Conta autenticada (login Google/Apple/email)** para salvar rotas e acessar estatísticas.
6. **Estatísticas**: distância total, kWh consumidos, tempo total de viagem e recarga.
7. **Interface elegante e acessível**: tema claro/escuro, cores vibrantes, tipografia legível, design intuitivo.

---

## 🏗️ Arquitetura

O projeto segue **Clean Architecture** com **BLoC** no front:

* **Domain**: entidades, value objects, repositórios abstratos, casos de uso.
* **Data**: integração com **Google Directions API** (rotas) e **Google Places API** (postos de recarga), além de banco local (Isar/Sqflite).
* **Presentation**: telas em Flutter, estados controlados por BLoC, navegação com `go_router`.
* **Core**: configuração, injeção de dependência, utilitários, tratamento de erros.

---

## 🌐 Integrações externas

* **Google Places API** → localizar estações de recarga próximas ao trajeto.
* **Google Directions API** → calcular rotas, distâncias, tempo de viagem.
* **Google Maps SDK** → exibição de mapas, polylines e marcadores interativos.

---

## 🔋 Modelo de energia

Um **módulo de simulação** calcula o consumo de bateria e a energia necessária em cada trecho da viagem, considerando:

* distância,
* velocidade média e máxima,
* topografia (quando disponível),
* capacidade útil da bateria do veículo,
* buffer de segurança (10–15%).

---

## 📂 Documentação AI-Ready

O repositório conterá uma pasta `/docs` com:

* `index.md` (overview do projeto e mapa de navegação da documentação)
* `api.md` (spec OpenAPI + exemplos reais de integração com Google APIs)
* `ai-notes.md` (instruções para agentes de IA contribuírem no código/testes)
* `faq.md`, `ARCHITECTURE.md`, `contribuindo.md`, `Changelog.md`

---

## ✅ Benefícios

* **Segurança**: garante que o motorista não fique sem energia entre os pontos.
* **Praticidade**: planejamento rápido, inclusive sem login.
* **Confiabilidade**: dados vindos do ecossistema Google (Maps + Places).
* **Escalabilidade**: arquitetura modular (Clean Arch), fácil de manter e expandir.