package mies

class Entidad implements Serializable {

    String nombre
    String direccion
    String sigla
    String objetivo
    String telefono
    String fax
    String email
    String observaciones

    static auditable = [ignore: []]
    static mapping = {
        table 'entd'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'entd__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'entd__id'
            nombre column: 'entdnmbr'
            direccion column: 'entddire'
            sigla column: 'entdsgla'
            objetivo column: 'entdobjt'
            telefono column: 'entdtelf'
            fax column: 'entdfaxx'
            email column: 'entdmail'
            observaciones column: 'entdobsr'
        }
    }
    static constraints = {
        nombre(size: 1..63, blank: false, attributes: [mensaje: 'Nombre de la entidad o ministerio'])
        direccion(size: 1..127, blank: true, nullable: true, attributes: [mensaje: 'Dirección de la entidad o ministerio'])
        sigla(size: 1..7, blank: true, nullable: true, attributes: [mensaje: 'Sigla identificativa (por ejemplo, MIES)'])
        objetivo(size: 1..63, blank: true, nullable: true, attributes: [mensaje: 'Objetivo institucional o de la entidad'])
        telefono(size: 1..63, blank: true, nullable: true, attributes: [mensaje: 'Teléfonos, se los separa con “;”'])
        fax(size: 1..63, blank: true, nullable: true, attributes: [mensaje: 'Números de fax, se los separa con “;”'])
        email(size: 1..63, blank: true, nullable: true, attributes: [mensaje: 'Dirección de correo electrónico institucional'])
        observaciones(size: 1..127, blank: true, nullable: true, attributes: [mensaje: 'Observaciones'])
    }

    String toString() {
        return this.nombre
    }
}