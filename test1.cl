__kernel void vector_copy(__global float *dt1,__global float *eps,
							__global float4 *pos,
							__global float4 *val) {
	int i = get_global_id(0);
	*dt1 = 3.1;
	*eps = 2.1;
	pos->x = 100;
	pos->y = 123;
	pos->z = 200;
	val[i].x = 2;
	val[i].y = 2;
	val[i].z = 2;
	val[i].w = 2;
}
