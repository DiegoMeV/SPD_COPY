prompt --application/pages/page_00003
begin
--   Manifest
--     PAGE: 00003
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.21'
,p_default_workspace_id=>23568272425167888
,p_default_application_id=>154
,p_default_id_offset=>292021538769791282
,p_default_owner=>'SIIF'
);
wwv_flow_imp_page.create_page(
 p_id=>3
,p_name=>'En Construccion'
,p_alias=>'EN-CONSTRUCCION'
,p_step_title=>unistr('P\00E1gina En Construcci\00F3n')
,p_autocomplete_on_off=>'OFF'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'    /* Contenedor principal */',
'    .apx-cons-wrapper {',
'        display: flex;',
'        flex-direction: column;',
'        align-items: center;',
'        justify-content: center;',
'        padding: 4rem 2rem;',
'        text-align: center;',
unistr('        background-color: transparent; /* Se adapta al fondo de tu regi\00F3n APEX */'),
'        font-family: inherit; /* Hereda la fuente del Universal Theme */',
'        color: var(--ut-content-text-color, #333); /* Intenta usar variables de APEX o gris por defecto */',
'    }',
'',
unistr('    /* Ilustraci\00F3n SVG */'),
'    .apx-cons-illustration {',
'        width: 100%;',
'        max-width: 350px;',
'        height: auto;',
'        margin-bottom: 2rem;',
'    }',
'',
'    /* Animaciones */',
'    @keyframes float {',
'        0%, 100% { transform: translateY(0); }',
'        50% { transform: translateY(-10px); }',
'    }',
'    ',
'    @keyframes spin-slow {',
'        from { transform: rotate(0deg); transform-origin: center; }',
'        to { transform: rotate(360deg); transform-origin: center; }',
'    }',
'',
'    @keyframes spin-reverse {',
'        from { transform: rotate(360deg); transform-origin: center; }',
'        to { transform: rotate(0deg); transform-origin: center; }',
'    }',
'',
'    .apx-anim-float { animation: float 4s ease-in-out infinite; }',
'    .apx-anim-gear-1 { animation: spin-slow 10s linear infinite; transform-origin: 50% 50%; }',
'    .apx-anim-gear-2 { animation: spin-reverse 8s linear infinite; transform-origin: 50% 50%; }',
'',
unistr('    /* Tipograf\00EDa */'),
'    .apx-cons-title {',
'        font-size: 2rem;',
'        font-weight: 700;',
'        margin-bottom: 1rem;',
'        color: #24292e;',
'    }',
'',
unistr('    /* Ajuste para modo oscuro autom\00E1tico si APEX lo usa */'),
'    :where(.u-Color-BG--dark, .a-Dark) .apx-cons-title {',
'        color: #f0f0f0;',
'    }',
'',
'    .apx-cons-subtitle {',
'        font-size: 1.1rem;',
'        color: #586069;',
'        max-width: 600px;',
'        line-height: 1.6;',
'        margin-bottom: 2rem;',
'    }',
'',
'    :where(.u-Color-BG--dark, .a-Dark) .apx-cons-subtitle {',
'        color: #a0a0a0;',
'    }',
'',
'    /* Barra de progreso decorativa */',
'    .apx-cons-progress-container {',
'        width: 200px;',
'        height: 6px;',
'        background-color: #e1e4e8;',
'        border-radius: 3px;',
'        overflow: hidden;',
'        margin-bottom: 2rem;',
'    }',
'',
'    .apx-cons-progress-bar {',
'        width: 60%; /* Porcentaje de avance simulado */',
'        height: 100%;',
'        background: linear-gradient(90deg, #0572ce, #50bfff); /* Colores estilo APEX */',
'        border-radius: 3px;',
'        position: relative;',
'    }',
'',
'    /* Efecto de brillo en la barra */',
'    .apx-cons-progress-bar::after {',
'        content: '''';',
'        position: absolute;',
'        top: 0;',
'        left: 0;',
'        bottom: 0;',
'        right: 0;',
'        background-image: linear-gradient(',
'            -45deg,',
'            rgba(255, 255, 255, .2) 25%,',
'            transparent 25%,',
'            transparent 50%,',
'            rgba(255, 255, 255, .2) 50%,',
'            rgba(255, 255, 255, .2) 75%,',
'            transparent 75%,',
'            transparent',
'        );',
'        background-size: 20px 20px;',
'        animation: move-stripes 1s linear infinite;',
'    }',
'',
'    @keyframes move-stripes {',
'        0% { background-position: 0 0; }',
'        100% { background-position: 20px 20px; }',
'    }',
'',
unistr('    /* Bot\00F3n estilo APEX (Opcional) */'),
'    .apx-cons-btn {',
'        display: inline-block;',
'        padding: 0.75rem 1.5rem;',
unistr('        background-color: #0572ce; /* Azul APEX est\00E1ndar */'),
'        color: white;',
'        border-radius: 4px;',
'        text-decoration: none;',
'        font-weight: 500;',
'        transition: background-color 0.2s;',
'        border: none;',
'        cursor: pointer;',
'    }',
'',
'    .apx-cons-btn:hover {',
'        background-color: #045cb8;',
'        box-shadow: 0 2px 4px rgba(0,0,0,0.1);',
'    }',
''))
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'11'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(644170784391333928)
,p_plug_name=>unistr('P\00E1gina En Construcci\00F3n')
,p_region_template_options=>'#DEFAULT#:t-HeroRegion--featured t-HeroRegion--centered:t-HeroRegion--hideIcon'
,p_plug_template=>2674017834225413037
,p_plug_display_sequence=>10
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="apx-cons-wrapper">',
unistr('    <!-- Ilustraci\00F3n SVG Integrada (Sin dependencias externas) -->'),
'    <svg class="apx-cons-illustration apx-anim-float" viewBox="0 0 400 300" xmlns="http://www.w3.org/2000/svg">',
'        <!-- Fondo decorativo -->',
'        <circle cx="200" cy="150" r="130" fill="#f1f5f9" />',
'        ',
'        <!-- Engranaje Grande -->',
'        <g class="apx-anim-gear-1" transform-origin="120 120">',
'            <path fill="#cbd5e1" d="M170,120c0-27.6-22.4-50-50-50s-50,22.4-50,50s22.4,50,50,50S170,147.6,170,120z M120,155 c-19.3,0-35-15.7-35-35s15.7-35,35-35s35,15.7,35,35S139.3,155,120,155z"/>',
'            <path fill="#94a3b8" d="M158.5,104.6l10.4-6c1.9-1.1,2.5-3.5,1.4-5.4l-5-8.7c-1.1-1.9-3.5-2.5-5.4-1.4l-10.4,6 c-2.6-2.2-5.5-4.1-8.6-5.6l2-11.8c0.4-2.1-1.1-4.1-3.3-4.5l-10-1.7c-2.1-0.4-4.1,1.1-4.5,3.3l-2,11.8c-3.4,0.9-6.6,2.2-9.6,3.9 l-8.1-8'
||'.8c-1.5-1.6-4-1.7-5.6-0.2l-7.4,6.8c-1.6,1.5-1.7,4-0.2,5.6l8.1,8.8c-2.2,2.6-4.1,5.5-5.6,8.6l-11.8-2 c-2.1-0.4-4.1,1.1-4.5,3.3l-1.7,10c-0.4,2.1,1.1,4.1,3.3,4.5l11.8,2c0.9,3.4,2.2,6.6,3.9,9.6l-8.8,8.1c-1.6,1.5-1.7,4-0.2,5.6 l6.8,7.4c1.5,1.6,4,1.7,5.6,0.'
||'2l8.8-8.1c2.6,2.2,5.5,4.1,8.6,5.6l-2,11.8c-0.4,2.1,1.1,4.1,3.3,4.5l10,1.7 c2.1,0.4,4.1-1.1,4.5-3.3l2-11.8c3.4-0.9,6.6-2.2,9.6-3.9l8.1,8.8c1.5,1.6,4,1.7,5.6,0.2l7.4-6.8c1.6-1.5,1.7-4,0.2-5.6l-8.1-8.8 c2.2-2.6,4.1-5.5,5.6-8.6l11.8,2c2.1,0.4,4.1-1.1,4.5'
||'-3.3l1.7-10C161.6,108.2,160.1,106.2,158.5,104.6z"/>',
'        </g>',
'',
unistr('        <!-- Engranaje Peque\00F1o -->'),
'        <g class="apx-anim-gear-2" transform-origin="280 140">',
'            <path fill="#94a3b8" d="M310,140c0-16.6-13.4-30-30-30s-30,13.4-30,30s13.4,30,30,30S310,156.6,310,140z M280,161 c-11.6,0-21-9.4-21-21s9.4-21,21-21s21,9.4,21,21S291.6,161,280,161z"/>',
'            <path fill="#64748b" d="M311.6,145.5l8.3,1.4c1.5,0.3,2.5,1.7,2.3,3.2l-1.4,8.3c-0.3,1.5-1.7,2.5-3.2,2.3l-8.3-1.4 c-1.5,2-3.3,3.8-5.3,5.3l4.8,6.9c0.9,1.2,0.6,3-0.7,3.8l-7.1,4.9c-1.2,0.9-3,0.6-3.8-0.7l-4.8-6.9c-2.3,0.8-4.8,1.2-7.3,1.2v8.4 c0'
||',1.5-1.2,2.8-2.8,2.8h-8.6c-1.5,0-2.8-1.2-2.8-2.8v-8.4c-2.5,0-5-0.4-7.3-1.2l-4.8,6.9c-0.9,1.2-2.6,1.5-3.8,0.7l-7.1-4.9 c-1.2-0.9-1.5-2.6-0.7-3.8l4.8-6.9c-2-1.5-3.8-3.3-5.3-5.3l-8.3,1.4c-1.5,0.3-3-0.8-3.2-2.3l-1.4-8.3c-0.3-1.5,0.8-3,2.3-3.2 l8.3-1.4c-0'
||'.8-2.3-1.2-4.8-1.2-7.3h-8.4c-1.5,0-2.8-1.2-2.8-2.8v-8.6c0-1.5,1.2-2.8,2.8-2.8h8.4c0-2.5,0.4-5,1.2-7.3l-8.3-1.4 c-1.5-0.3-2.5-1.7-2.3-3.2l1.4-8.3c0.3-1.5,1.7-2.5,3.2-2.3l8.3,1.4c1.5-2,3.3-3.8,5.3-5.3l-4.8-6.9c-0.9-1.2-0.6-3,0.7-3.8 l7.1-4.9c1.2-0.9,3-'
||'0.6,3.8,0.7l4.8,6.9c2.3-0.8,4.8-1.2,7.3-1.2v-8.4c0-1.5,1.2-2.8,2.8-2.8h8.6c1.5,0,2.8,1.2,2.8,2.8v8.4 c2.5,0,5,0.4,7.3,1.2l4.8-6.9c0.9-1.2,2.6-1.5,3.8-0.7l7.1,4.9c1.2,0.9,1.5,2.6,0.7,3.8l-4.8,6.9c2,1.5,3.8,3.3,5.3,5.3l8.3-1.4 c1.5-0.3,3,0.8,3.2,2.3l1.'
||'4,8.3c0.3,1.5-0.8,3-2.3,3.2l-8.3,1.4C310.4,140.7,310.8,143.2,311.6,145.5z"/>',
'        </g>',
'',
unistr('        <!-- Cono de Tr\00E1fico -->'),
'        <g transform="translate(165, 130)">',
'             <!-- Base -->',
'            <ellipse cx="35" cy="100" rx="50" ry="15" fill="#f59e0b"/>',
'            <path d="M35,108c-20,0-40-3-40-8h80C75,105,55,108,35,108z" fill="#d97706"/>',
'             <!-- Cuerpo cono -->',
'            <path d="M10,100 L25,10 L45,10 L60,100 Z" fill="#f59e0b"/>',
'             <!-- Rayas blancas -->',
'            <path d="M18,55 L52,55 L55,75 L15,75 Z" fill="#ffffff" opacity="0.9"/>',
'            <path d="M22,30 L48,30 L50,45 L20,45 Z" fill="#ffffff" opacity="0.9"/>',
'        </g>',
'    </svg>',
'',
unistr('    <h2 class="apx-cons-title">Funcionalidad en Construcci\00F3n</h2>'),
'    ',
'    <p class="apx-cons-subtitle">',
unistr('      Estamos trabajando para habilitar esta secci\00F3n.'),
'',
'    </p class="apx-cons-subtitle">',
'<p>Gracias por tu paciencia.</p>',
'    <!-- Barra de progreso visual -->',
'    <div class="apx-cons-progress-container">',
'        <div class="apx-cons-progress-bar"></div>',
'    </div>',
'',
'</div>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp.component_end;
end;
/
