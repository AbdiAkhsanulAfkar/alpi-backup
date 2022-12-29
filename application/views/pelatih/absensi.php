<div class="card-body">
    <?php if (!$absensi) : ?>
        <div><a href="<?= base_url('pelatih/tambah_absensi/' . $data . '?pertemuan=' . $data) ?>" class="btn btn-success">Absen</a></div>
    <?php else : echo "Siswa sudah absen!";
    endif ?>

    <div class="table-responsive mt-3">
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Nama</th>
                    <th>Kelas</th>
                    <th>Pertemuan</th>
                    <th>Kehadiran</th>
                </tr>
            </thead>
            <tbody>
                <?php $no = 1;
                if ($absensi) :
                    foreach ($absensi as $d) : ?>
                        <tr>
                            <td><?= $no++ ?></td>
                            <td><?= $d->nama ?></td>
                            <td><?= $d->kelas ?></td>
                            <td><?php echo $data ?></td>
                            <td>
                                <?php
                                if ($d->kehadiran == "") {
                                    echo "Belum Absen";
                                } else {
                                    echo $d->kehadiran;
                                }
                                ?></td>
                        <?php endforeach; ?>
                        <?php

                        ?>
                        </tr>
                        <?php else :
                        foreach ($not_absen_yet as $d) : ?>
                            <tr>
                                <td><?= $no++ ?></td>
                                <td><?= $d->nama ?></td>
                                <td><?= $d->kelas ?></td>
                                <td><?php echo $data ?></td>
                                <td>Belum Absen</td>
                            <?php endforeach; ?>
                        <?php
                    endif;
                        ?>
                            </tr>
            </tbody>
        </table>
    </div>
</div>