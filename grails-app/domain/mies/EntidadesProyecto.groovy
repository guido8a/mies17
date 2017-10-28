package mies

class EntidadesProyecto implements Serializable {
    UnidadEjecutora unidad
    TipoParticipacion tipoPartisipacion
    Proyecto proyecto
    double monto
    String rol
    static auditable = [ignore: []]
    static mapping = {
        table 'etpy'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'etpy__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'etpy__id'
            unidad column: 'unej__id'
            tipoPartisipacion column: 'tppt__id'
            proyecto column: 'proy__id'
            monto column: 'etpymnto'
            rol column: 'etpy_rol'
            tipoPartisipacion column: 'tppt__id'
        }
    }
    static constraints = {
        unidad(blank: true, nullable: true, attributes: [mensaje: 'Unidad ejecutora'])
        tipoPartisipacion(blank: true, nullable: true, attributes: [mensaje: 'Tipo de Participación'])
        proyecto(blank: true, nullable: true, attributes: [mensaje: 'Proyecto'])
        monto(blank: true, nullable: true, attributes: [mensaje: 'Monto que aportan'])
        rol(size: 1..1023, blank: true, nullable: true, attributes: [mensaje: 'Rol que desempeñan'])
    }

    String toString() {
        "${this.descripcion}"
    }
}