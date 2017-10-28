package mies

class SubSecretaria implements Serializable {
    Entidad entidad
    String nombre
    String titulo
    static auditable = [ignore: []]
    static mapping = {
        table 'sbsc'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'sbsc__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'sbsc__id'
            entidad column: 'entd__id'
            nombre column: 'sbscnmbr'
            titulo column: 'sbsctitl'
        }
    }
    static constraints = {
        entidad(blank: true, nullable: true, attributes: [mensaje: 'Entidad'])
        nombre(size: 1..63, blank: false, attributes: [mensaje: 'Nombre de la subsecretaría'])
        titulo(size: 1..63, blank: true, nullable: true, attributes: [mensaje: 'Título formal'])
    }

    String toString() {
        return this.nombre
    }
}