// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title CulturaMadagascar
 * @dev Registro de tecnicas de arroz y aprovechamiento de residuos termicos.
 * Serie: Sabores de Africa (11/54)
 */
contract CulturaMadagascar {

    struct Plato {
        string nombre;
        string ingredientes;
        string preparacion;
        bool usaRanovola;         // Aprovechamiento del arroz pegado/quemado
        string especiaPrincipal;  // Vainilla, Clavo, Pimienta de Madagascar
        bool esProteinaZebu;      // El buey sagrado de la isla
        uint256 likes;
        uint256 dislikes;
    }

    mapping(uint256 => Plato) public registroCulinario;
    uint256 public totalRegistros;
    address public owner;

    constructor() {
        owner = msg.sender;
        // Inauguramos con el Romazava (Plato nacional)
        registrarPlato(
            "Romazava", 
            "Carne de zebu, hojas de anamalao, jengibre, tomate.",
            "Caldo de carne con hojas verdes que producen un efecto de hormigueo en la lengua.",
            true, 
            "Jengibre", 
            true
        );
    }

    function registrarPlato(
        string memory _nombre, 
        string memory _ingredientes,
        string memory _preparacion,
        bool _ranovola, 
        string memory _especia,
        bool _zebu
    ) public {
        require(bytes(_nombre).length > 0, "Nombre requerido");

        totalRegistros++;
        registroCulinario[totalRegistros] = Plato({
            nombre: _nombre,
            ingredientes: _ingredientes,
            preparacion: _preparacion,
            usaRanovola: _ranovola,
            especiaPrincipal: _especia,
            esProteinaZebu: _zebu,
            likes: 0,
            dislikes: 0
        });
    }

    function darLike(uint256 _id) public {
        require(_id > 0 && _id <= totalRegistros, "ID invalido");
        registroCulinario[_id].likes++;
    }

    function darDislike(uint256 _id) public {
        require(_id > 0 && _id <= totalRegistros, "ID invalido");
        registroCulinario[_id].dislikes++;
    }

    function consultarPlato(uint256 _id) public view returns (
        string memory nombre,
        bool ranovola,
        string memory especia,
        bool zebu,
        uint256 likes
    ) {
        require(_id > 0 && _id <= totalRegistros, "ID inexistente");
        Plato storage p = registroCulinario[_id];
        return (p.nombre, p.usaRanovola, p.especiaPrincipal, p.esProteinaZebu, p.likes);
    }
}
