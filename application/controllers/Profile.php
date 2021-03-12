<?php
defined('BASEPATH') or exit('No direct script access allowed');


class Profile extends MY_Controller
{


	public function __construct()
	{
		parent::__construct();

		$this->require_logged_in();

		// Required libraries, models etc
		$this->load->library('email');
		$this->load->model('crud_model');
		$this->load->model('bookings_model');
		$this->load->model('users_model');
	}

	function get_absen(){
	$id = $this->session->userdata['logged_in']['id']; // dapatkan id user yg login
	$this->db->select('id, firstname');
	$this->db->where('user_id', $id);//
	$this->db->from('firstname');
	$query = $this->db->get();
	return $query->result();
}
function index()
{
		// Get User ID
	$user_id = $this->userauth->user->user_id;

		// Get bookings for a room if this user owns one
	$this->data['myroom'] = $this->bookings_model->ByRoomOwner($user_id);
		// Get all bookings made by this user (only staff ones)
	$this->data['mybookings'] = $this->bookings_model->ByUser($user_id);
		// Get totals
	$this->data['total'] = $this->bookings_model->TotalNum($user_id);

		// Get jadwal
	$this->data['jadwal'] = $this->bookings_model->get_jadwal($user_id);

	$this->data['title'] = 'My Profile';
	$this->data['showtitle'] = $this->data['title'];

	// Get data profil users
	$this->data['users'] = $this->bookings_model->get_profile($user_id);

		// var_dump($this->data['jadwal']);
		// die();

	$this->data['body'] = $this->load->view('profile/profile_index', $this->data, TRUE);

	return $this->render();
}


function edit()
{
		// Get User ID
	$user_id = $this->userauth->user->user_id;

	$this->data['users'] = $this->bookings_model->get_profile($user_id);

// Get data profil users
	$this->data['user'] = $this->users_model->Get($user_id);

	$columns = array(
		'c1' => array(
			'width' => '70%',
			'content' => $this->load->view('profile/profile_edit', $this->data, TRUE),
		),
		'c2' => array(
			'width' => '30%',
			'content' => $this->load->view('profile/profile_edit_side', $this->data, TRUE),
		),
	);

	$this->data['title'] = 'Edit my details';
	$this->data['showtitle'] = $this->data['title'];
	$this->data['body'] = $this->load->view('columns', $columns, TRUE);

	return $this->render();
}


function save()
{
		// Get User ID
	$user_id = $this->userauth->user->user_id;

	$this->load->library('form_validation');
	$this->form_validation->set_rules('password1', 'Password', 'min_length[6]');
	$this->form_validation->set_rules('password2', 'Password (confirm)', 'min_length[6]|matches[password1]');
	$this->form_validation->set_rules('email', 'Email address', 'max_length[255]|valid_email');
	$this->form_validation->set_rules('firstname', 'First name', 'max_length[20]');
	$this->form_validation->set_rules('lastname', 'Last name', 'max_length[20]');
	$this->form_validation->set_rules('displayname', 'Display name', 'max_length[20]');
	$this->form_validation->set_rules('extension', 'Extension', 'max_length[10]');

	if ($this->form_validation->run() == FALSE) {
			// Validation failed
		return $this->edit();
	}

		// Validation passed!
	$data = array(
		'email' => $this->input->post('email'),
		'firstname' => $this->input->post('firstname'),
		'lastname' => $this->input->post('lastname'),
		'displayname' => $this->input->post('displayname'),
		'ext' => $this->input->post('ext'),
	);

		// Only update password if one was supplied
	if ($this->input->post('password1') && $this->input->post('password2')) {
		$data['password'] = password_hash($this->input->post('password1'), PASSWORD_DEFAULT);
	}

		// Update session variable with displayname
	$this->session->set_userdata('displayname', $data['displayname']);

		// Now call database to update user and load appropriate message for return value
	if (!$this->crud_model->Edit('users', 'user_id', $user_id, $data)) {
		$flashmsg = msgbox('error', 'A database error occured while updating your details.');
	} else {
		$flashmsg = msgbox('info', 'Your details have been successfully updated.');
	}

		// Go back to index
	$this->session->set_flashdata('saved', $flashmsg);
	redirect('profile');
}

function ganti_foto(){
	$user_id = $this->input->post('user_id');
	$foto = $_FILES['foto']['name'];


	if($foto){
		$config['upload_path'] = './foto';
		$config['allowed_types'] = 'jpg|jpeg|png|tiff';

		$this->load->library('upload', $config);

		if($this->upload->do_upload('foto')){
			$foto = $this->upload->data('file_name');
			$this->db->set('foto', $foto);
		} else{
			redirect('profile');
		}
	}

	$data = array(
		'foto' => $foto

	);

	$this->db->query("UPDATE users SET foto='$foto' where user_id=$user_id");

	redirect('profile');
}

}
