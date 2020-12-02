using UnityEngine;
using System.Collections;
using System.Net;
using System.Net.Sockets;
using System.Linq;
using System;
using System.IO;
using System.Text;


public class cartControl : MonoBehaviour
{

    // Use this for initialization
    TcpListener listener;
    string[] splittedInput;
    String msg = null;
    int port = 55001;
    float pos = 0;
    public float ang = 0;

    void Start()
    {
        listener = new TcpListener(port);
        listener.Start();
        print("TCP Server Activated!");
        print("Listen: " + port.ToString());
    }
    // Update is called once per frame
    void FixedUpdate()
    {
        if (!listener.Pending())
        {
        }
        else
        {
            TcpClient client = listener.AcceptTcpClient();
            NetworkStream ns = client.GetStream();
            StreamReader reader = new StreamReader(ns);
            Console.WriteLine("Connected!");

            msg = reader.ReadToEnd();
            splittedInput = msg.Split(' ');
            print(splittedInput[0]);
            pos = float.Parse(splittedInput[0])/100000;
            ang = float.Parse(splittedInput[1])/1000000;
            GetComponent<Rigidbody>().velocity = new Vector3(pos, transform.position.y, transform.position.z);
            //print(pos);
            //GetComponent<Rigidbody>().position = new Vector3(pos, transform.position.y, transform.position.z);

        }
    }
}