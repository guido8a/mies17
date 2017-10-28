package mies

class GrupoDeAtencion implements Serializable {
    TipoGrupo tipoGrupo
    Proyecto proyecto
    int hombre
    int mujer
    static auditable = [ignore: []]
    static mapping = {
        table 'grat'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'grat__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'grat__id'
            tipoGrupo column: 'tpgr__id'
            proyecto column: 'proy__id'
            hombre column: 'grathmbr'
            mujer column: 'gratmujr'
        }
    }
    static constraints = {
        tipoGrupo(blank: true, nullable: true, attributes: [mensaje: 'Tipo de Grupo'])
        proyecto(blank: true, nullable: true, attributes: [mensaje: 'Proyecto'])
        hombre(blank: true, nullable: true, attributes: [mensaje: 'Número de hombres atendidos'])
        mujer(blank: true, nullable: true, attributes: [mensaje: 'Número de mujeres atendidas'])
    }
}