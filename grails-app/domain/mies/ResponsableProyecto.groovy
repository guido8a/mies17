package mies

class ResponsableProyecto implements Serializable {
    mies.seguridad.Usro responsable
    UnidadEjecutora unidad
    Proyecto proyecto
    Date desde
    Date hasta
    TipoResponsable tipo
    String observaciones
    static auditable = [ignore: []]
    static mapping = {
        table 'rspy'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'rspy__id'
        id generator: 'identity'
        version false
        columns {
            responsable column: 'usro__id'
            proyecto column: 'proy__id'
            desde column: 'rspydsde'
            hasta column: 'rspyhsta'
            tipo column: 'tprp__id'
            observaciones column: 'rspyobsr'
            unidad column: 'unej__id'
        }
    }
    static constraints = {
        responsable(blank: true, nullable: true, attributes: [mensaje: 'Responsable'])
        proyecto(blank: true, nullable: true, attributes: [mensaje: 'Proyecto'])
        desde(blank: true, nullable: true, attributes: [mensaje: 'Responsable desde (fecha)'])
        hasta(blank: true, nullable: true, attributes: [mensaje: 'Responsable hasta (fecha)'])
        tipo(blank: false, nullable: false, attributes: [mensaje: 'Tipo de responsable'])
        observaciones(size: 1..127, blank: true, nullable: true, attributes: [mensaje: 'Observaciones'])
        unidad(blank:true,nullable: true)
    }

    String toString() {
        return this.responsable.persona.nombre + " " + this.responsable.persona.apellido
    }
}