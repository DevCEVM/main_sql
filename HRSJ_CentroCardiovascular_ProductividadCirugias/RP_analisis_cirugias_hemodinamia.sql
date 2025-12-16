-- RP_analisis_cirugias_hemodinamia.sql
-- Cristopher Villegas
-- 15/12/25

select
    concat(p.nombre, ' ',p.paterno,' ',p.materno) as Nombre_Paciente,
    v.medico_asignado Médico,
    ac.cirugia Cirugía,
    a.inicio_anestesia Fecha,
    e.especialidad Especialidad_Médico,
    cue.servicioMedico Aseguradora,
    case when cue.servicioMedico is null then 'Cancelado ' else cue.servicioMedico end AseguradoTest,
    case when a.visitaID == 0 then 'Cancelado' else 'Realizado' end Estado
from sah_hrsj_valle.agenda a
    left join sah_hrsj_valle.agenda_cirugias ac on ac.agendaID = a.id
    left join sah_hrsj_valle.cuentaspacientes cue on a.visitaID = cue.visitaId
    left join sah_hrsj_valle.visitas v on a.visitaID = v.id
    left join sah_hrsj_valle.users_especialidad usesp on v.medicoID = usesp.userID
    left join sah_hrsj_valle.especialidad e on usesp.especialidadID = e.id
    left join sah_hrsj_valle.pacientes p on v.pacienteID = p.id
        where a.habitacionID = 182
            and a.fecha >'2025-01-01 00:00:00'
            and a.fecha <'2026-01-01 00:00:00'
            and a.visitaID != 0