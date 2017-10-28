package mies

class Proyecto implements Serializable {
    UnidadEjecutora unidadEjecutora
    Etapa etapa
    Fase fase
    TipoProducto tipoProducto
    EstadoProyecto estadoProyecto
    Linea linea
    TipoInversion tipoInversion
    Cobertura cobertura
    Calificacion calificacion
    Programa programa
    String codigoProyecto
    Date fechaRegistro
    Date fechaModificacion
    String nombre
    Double monto
    String producto
    String descripcion
    Date fechaInicioPlanificada
    Date fechaInicio
    Date fechaFinPlanificada
    Date fechaFin
    Integer mes = 1
    String problema
    Integer informacionDias = 0
    String subPrograma
    String aprobado

    ObjetivoEstrategicoProyecto objetivoEstrategico

    EjeProgramatico ejeProgramatico

    String lineaBase
    String poblacionObjetivo

    ObjetivoGobiernoResultado objetivoGobiernoResultado

    ProgramaPresupuestario programaPresupuestario

    String codigoEsigef

    static auditable = [ignore: []]
    static mapping = {
        table 'proy'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'proy__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'proy__id'
            unidadEjecutora column: 'unej__id'
            etapa column: 'etpa__id'
            fase column: 'fase__id'
            tipoProducto column: 'tppd__id'
            estadoProyecto column: 'edpy__id'
            linea column: 'lnea__id'
            tipoInversion column: 'tpiv__id'
            cobertura column: 'cbrt__id'
            calificacion column: 'calf__id'
            programa column: 'prgr__id'
            codigoProyecto column: 'proy_cup'
            fechaRegistro column: 'proyfcrg'
            fechaModificacion column: 'proyfcmf'
            nombre column: 'proynmbr'
            monto column: 'proymnto'
            producto column: 'proyprdt'
            descripcion column: 'proydscr'
            fechaInicioPlanificada column: 'proyfipl'
            fechaInicio column: 'proyfcin'
            fechaFinPlanificada column: 'proyffpl'
            fechaFin column: 'proyfcfn'
            mes column: 'proymess'
            problema column: 'proyprbl'
            informacionDias column: 'proyifdd'
            subPrograma column: 'proysbpr'
            aprobado column: 'proyapbd'

            objetivoEstrategico column: 'obes__id'
            ejeProgramatico column: 'ejpg__id'
            lineaBase column: 'proylnbs'
            poblacionObjetivo column: 'pbob'

            objetivoGobiernoResultado column: 'obgr__id'

            programaPresupuestario column: 'pgps__id'

            codigoEsigef column: 'proysigf'
        }
    }
    static constraints = {
        unidadEjecutora(blank: true, nullable: true, attributes: [mensaje: 'Unidad Ejecutora'])
        etapa(blank: true, nullable: true, attributes: [mensaje: 'Etapa'])
        fase(blank: true, nullable: true, attributes: [mensaje: 'Fase'])
        tipoProducto(blank: true, nullable: true, attributes: [mensaje: 'Tipo de Producto'])
        estadoProyecto(blank: true, nullable: true, attributes: [mensaje: 'Estado del Proyecto'])
        linea(blank: true, nullable: true, attributes: [mensaje: 'Lineamiento de inversión'])
        tipoInversion(blank: true, nullable: true, attributes: [mensaje: 'Tipo de Inversión'])
        cobertura(blank: true, nullable: true, attributes: [mensaje: 'Cobertura'])
        calificacion(blank: true, nullable: true, attributes: [mensaje: 'Calificación'])
        programa(blank: true, nullable: true, attributes: [mensaje: 'Programa al que pertenece'])
        codigoProyecto(unique:true, size: 1..24, blank: true, nullable: true, attributes: [mensaje: 'CUP (código único del proyecto según la Senplades)'])
        fechaRegistro(blank: true, nullable: true, attributes: [mensaje: 'Fecha de Registro en la SENPLADES'])
        fechaModificacion(blank: true, nullable: true, attributes: [mensaje: 'Fecha de Modificación del proyecto'])
        nombre(size: 1..255, blank: false, nullable: false, attributes: [mensaje: 'Nombre del proyecto'])
        monto(blank: true, nullable: true, attributes: [mensaje: 'Monto total del proyecto'])
        producto(size: 1..1023, blank: true, nullable: true, attributes: [mensaje: 'Producto principal del proyecto'])
        descripcion(size: 1..1024, blank: true, nullable: true, attributes: [mensaje: 'Descripción del proyecto'])
        fechaInicioPlanificada(blank: true, nullable: true, attributes: [mensaje: 'Fecha de inicio según el plan o programada'])
        fechaInicio(blank: true, nullable: true, attributes: [mensaje: 'Fecha de Inicio real'])
        fechaFinPlanificada(blank: true, nullable: true, attributes: [mensaje: 'Fecha de finalización según el plan o programada'])
        fechaFin(blank: true, nullable: true, attributes: [mensaje: 'Fecha de finalización real'])
        mes(blank: true, nullable: true, attributes: [mensaje: 'Duración del proyecto en meses'])
        problema(size: 1..1024, blank: true, nullable: true, attributes: [mensaje: 'Problema que ataca el proyecto'])
        informacionDias(blank: true, nullable: true, attributes: [mensaje: 'Periodo de información en días para control de informes que debe enviar el responsable'])
        subPrograma(size: 1..2, blank: true, nullable: true, attributes: [mensaje: 'Subprograma al que pertenece, según el ESIGEF'])
        aprobado(size: 0..1, blank: true, nullable: true, attributes: [mensaje: 'Aprobado o no'])

        objetivoEstrategico(blank: true, nullable: true, attributes: [mensaje: 'Objetivo Estratégico'])
        ejeProgramatico(size: 0..1023, blank: true, nullable: true, attributes: [mensaje: 'Eje Programático del proyecto'])
        lineaBase(size: 0..1023, blank: true, nullable: true, attributes: [mensaje: 'Línea Base del proyecto'])
        poblacionObjetivo(size: 0..1023, blank: true, nullable: true, attributes: [mensaje: 'Población objetivo del proyecto'])

        objetivoGobiernoResultado(blank: false, nullable: false, attributes: [mensaje: 'Objetivos de gobierno por resultados'])

        programaPresupuestario(blank: false, nullable: false, attributes: [mensaje: 'Programa presupuestario'])

        codigoEsigef(size: 0..3, blank: true, nullable: true, attributes: [mensaje: 'Número proyecto eSIGEF'])
    }

    String toString() {
        if (nombre.size() > 20) {
            def partes = nombre.split(" ")
            def cont = 0
            def des = ""
            partes.each {
                cont += it.size()
                if (cont < 22)
                    des += " " + it
            }
            return des + "... "

        } else {
            return "${this.nombre}"
        }

    }

    String toStringLargo() {
        if (nombre.size() > 65) {
            def partes = nombre.split(" ")
            def cont = 0
            def des = ""
            partes.each {
                cont += it.size()
                if (cont < 65)
                    des += " " + it
            }
            return des + "... "

        } else {
            return "${this.nombre}"
        }

    }

    String toStringCompleto() {
        return this.nombre
    }

}