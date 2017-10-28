package mies

class PresupuestoUnidad {

    UnidadEjecutora unidad
    Anio anio
    double maxInversion
    double maxCorrientes
    double originalCorrientes=0
    double originalInversion=0
    EjeProgramatico ejeProgramatico
    ObjetivoEstrategicoProyecto objetivoEstrategico
    ObjetivoGobiernoResultado objetivoGobiernoResultado
    Politica politica
    int aprobadoCorrientes=0
    int aprobadoInversion=0

    static auditable = [ignore: []]

    static mapping = {
        table 'prue'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'prue__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'prue__id'
            unidad column: 'unej__id'
            anio column: 'anio__id'
            maxInversion column: 'pruemxiv'
            maxCorrientes column: 'pruemxcr'
            ejeProgramatico column: 'ejpg__id'
            objetivoEstrategico column: 'obes__id'
            objetivoGobiernoResultado column: 'obgr__id'
            politica column: 'pltc__id'
            aprobadoCorrientes column: 'prueapcr'
            aprobadoInversion column: 'prueapin'
            originalCorrientes column: 'prueorcr'
            originalInversion column: 'prueorin'
        }
    }
    static constraints = {
        unidad(nullable: false, blank: false)
        anio(nullable: false, blank: false)
        maxInversion(nullable: false, blank: false)
        maxCorrientes(nullable: false, blank: false)
        ejeProgramatico(nullable: true,blank:true)
        objetivoEstrategico(nullable: true,blank:true)
        objetivoGobiernoResultado(nullable: true,blank:true)
        politica(nullable: true,blank:true)
    }

    String toString() {
        "${this.anio}:${this.maxInversion}:${this.maxCorrientes}"
    }
}
