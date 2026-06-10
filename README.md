# People Gallery - Projeto de estudo

App desenvolvido em UIKit para cadastro e gerenciamento de pessoas com foto. O projeto permite adicionar, visualizar, editar e excluir registros, além de persistir os dados localmente entre execuções do aplicativo.

Este projeto faz parte dos Projetos 10 e 12 do curso 100 Days of Swift, mas foi adaptado com foco em organização, arquitetura e escalabilidade, simulando um cenário mais próximo do mercado.

## O que o app faz

- Adiciona pessoas utilizando fotos da galeria
- Permite editar o nome de uma pessoa cadastrada
- Permite excluir pessoas
- Exibe foto e nome em uma UICollectionView
- Persiste os dados localmente utilizando UserDefaults e Codable
- Mantém as imagens armazenadas no diretório Documents

## Arquitetura

O projeto foi estruturado com separação de responsabilidades, isolando regras de armazenamento e persistência da camada de interface.

## Decisões importantes

- UIKit programático (sem Storyboard)
- Separação de responsabilidades através de Services
- Persistência utilizando Codable
- Estrutura organizada para facilitar manutenção e evolução
- Atualização eficiente da CollectionView utilizando `insertItems`, `reloadItems` e `deleteItems`

## Melhorias em relação ao projeto original

Comparado ao projeto do curso, foram feitas algumas adaptações:

- Interface totalmente programática
- Criação de `ImageStorageService` para gerenciamento de imagens
- Criação de `PersonStorageService` para persistência de dados
- Separação da lógica de armazenamento da ViewController
- Layout adaptativo para diferentes larguras de tela
- Uso de UICollectionView com atualizações específicas ao invés de recarregar toda a interface
- Estrutura preparada para crescimento futuro

## Conceitos praticados

- UICollectionView
- UICollectionViewCell
- UIImagePickerController
- UIAlertController
- Delegates
- Codable
- JSONEncoder
- JSONDecoder
- UserDefaults
- Persistência local
- Manipulação de arquivos no diretório Documents
