package mies.seguridad

import org.springframework.jdbc.core.JdbcTemplate

import java.sql.Connection
import java.sql.DriverManager
import java.text.SimpleDateFormat

class KerberosService {

    public save(params, dominio, perfil, usuario) {
        def nuevo = dominio.newInstance()
        if(nuevo.id) {
            nuevo = dominio.get(params.id)
        }
        nuevo.properties = params
        try {
            nuevo.save(flush: true)
        } catch (e) {
            println "ERROR: kerberos"
            println "catch " + e + "  causa " + e.cause
        }
        return nuevo
    }

    /**
     *
     * @param params toma params.id para eliminar, p.controllerName, p.actionName
     * @param dominio
     * @param perfil
     * @param usuario
     * @return
     */
    public delete(params, dominio, perfil, usuario) {
        try {
            dominio.delete(flush: true)

        } catch (e) {
            println "error delete " + e
            return false
        }
    }

/**
 *
 * @param nuevo objeto a guardar
 * @param dominio Dominio
 * @param perfil
 * @param usuario
 * @param actionName
 * @param controllerName
 * @param session
 * @return
 *
 * flow.producto= kerberosService.saveObject( flow.producto,ProductoBancario, session.perfil, session.usuario,actionName,controllerName,session)
 if(flow.producto.errors.getErrorCount()!=0){
 MANEJAR ERRORES AQUI
 } else {
 NO OCURRIERON ERRORES
 }*
 */
    public saveObject(nuevo, dominio, perfil, usuario, actionName, controllerName, session) {
        try {
            nuevo.save(flush: true)
        } catch (e) {
            println "ERROR: kerberos"
            println "catch " + e + "  causa " + e.cause
        }
        return nuevo
    }

    public saveModificacion(nuevo, dominio,usuario, session) {
        try {
            nuevo.save(flush: true)
        } catch (e) {
            println "ERROR: kerberos"
            println "catch " + e + "  causa " + e.cause
        }
        return nuevo
    }


    ///////////////////////////////////////////////////Funciones de base de datos ////////////////////////////////////////

    def getJavaConnection() {
        Connection dbConnection
        try {
            dbConnection = DriverManager.getConnection("jdbc:postgresql://10.0.0.3:5432/mies", "postgres", "postgres")
            println "coneccion " + dbConnection
        }
        catch (e) {
            println("Couldn’t get connection!  " + e);
        }
        return dbConnection
    }

///////////////////////////////////////////////////// ALERTAS \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


    boolean generarAlerta(from, to, mensaje, controlador, accion, id) {
        try {
            def alerta = new mies.alertas.Alerta()
            alerta.from = from
            alerta.usro = to
            alerta.mensaje = mensaje
            alerta.controlador = controlador
            alerta.accion = accion
            alerta.id_remoto = id
            alerta.fec_envio = new Date()
            if (alerta.save(flush: true))
                return true
            else
                return false
        } catch (e) {
            println "error generar alerta " + e
            return false
        }

    }

}