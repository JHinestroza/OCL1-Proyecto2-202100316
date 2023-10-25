import React from "react";
import Editor from '@monaco-editor/react';

function AreaTexto(props) {

    const handlerChangeEditor = (evt) => {
        props.handlerChange(evt.target.value)
    }

    return (
        <>
            <div >
                <label for="exampleFormControlTextarea1" style={{fontSize: "50px"}}>{props.text}</label>
                <textarea class="form-control" id="exampleFormControlTextarea1" rows={props.rows} onChange={handlerChangeEditor} value={props.value}></textarea>
                {props.comp}
            </div>
        </>
    )
}

export default AreaTexto;

// import React, { useState, useRef } from "react";
// import Editor from '@monaco-editor/react';
// import './Stilos.css';


//     return (
//         <>
//             <div className="container">
//                 <div class="column">
//                     <Editor
//                         height="45vh"
//                         language="javascript"
//                         theme="vs-dark"
//                         text={"Consola Entrada"}    
//                         onChange={handlerChangeEditor} 
                        
                        
//                     />
                    
//                 </div>
//             </div>
//         </>

//     )
// }

// export default AreaTexto;
