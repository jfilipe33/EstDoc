using UnityEngine;
using System.Collections;
using System.Net;
using System.Net.Sockets;
using System.Linq;
using System;
using System.IO;
using System.Text;


public class pendControl : MonoBehaviour
{
    [SerializeField]
    private cartControl cart;
    

    void Start()
    {
        
    }
    
    void Update()
    {

        transform.localEulerAngles = new Vector3(0, -cart.ang, 0);
            
    }
}