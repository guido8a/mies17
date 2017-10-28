package mies

class Proceso implements Serializable {
    String nombre
    String descripcion
    Date fecha
    Date fechaFin
    String estado
    String observaciones
    static auditable = [ignore: []]
    static mapping = {
        table 'prcs'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'prcs__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'prcs__id'
            nombre column: 'sbscnmbr'
            descripcion column: 'prcsdscr'
            fecha column: 'prcsfcha'
            fechaFin column: 'prcsfcfn'
            estado column: 'prcsetdo'
            observaciones column: 'prcsobsr'
        }
    }
    static constraints = {
        id(attributes:[mensaje:'Código secuencial del proceso'])
        nombre(size: 1..63, blank: false, attributes: [mensaje: 'Nombre del proceso'])
        descripcion(size: 1..255, blank: true, nullable: true, attributes: [mensaje: 'Descripción del proceso'])
        fecha(blank: true, nullable: true, attributes: [mensaje: 'Fecha de registro del proceso'])
        fechaFin(blank: true, nullable: true, attributes: [mensaje: 'Fecha en que se eliminó el proceso'])
        estado(size: 1..1, blank: true, nullable: true, attributes: [mensaje: 'Estado del proceso'])
        observaciones(size: 1..127, blank: true, nullable: true, attributes: [mensaje: 'Observaciones'])
    }

    String toString() {
        return this.nombre
    }
}