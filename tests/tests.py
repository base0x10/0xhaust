#!/usr/bin/env python3

from sys import argv
from os import listdir, popen, path
import random
import concurrent.futures


def compare_results(pmars_results, othermars_results):
    return (
        pmars_results[9] == othermars_results[0]
        and pmars_results[11] == othermars_results[4]
    )


def run_test(pmars, othermars, w1, loadfiles, num_tests):
    warrior_size = 100
    min_dist = 100
    core_size = 8000
    for w2 in loadfiles:
        print("Testing {} against {}".format(w1, w2))
        for i in range(num_tests):
            w2_offset = random.randint(warrior_size + min_dist, core_size - min_dist)
            pmars_cmd = "{} -b -F {} {} {} | tail -n +3".format(
                pmars, w2_offset, w1, w2
            )
            othermars_cmd = "{} -F {} {} {}".format(othermars, w2_offset, w1, w2)
            pmars_res = popen(pmars_cmd).read()
            othermars_res = popen(othermars_cmd).read()

            if compare_results(pmars_res, othermars_res) == False:
                print("Found an error: \n pmars_res {}, othermars_res {}, \n cmds = {} \n {}".format(
                    pmars_res, othermars_res, pmars_cmd, othermars_cmd
                ))


def run_tests(pmars, othermars, warriors, num_tests):
    # use pmars to convert each warrior into loadfile format
    warrior_list = list(filter(lambda x: x.endswith(".red"), listdir(warriors)))
    loadfiles = []
    for w in warrior_list:
        infile = path.join(warriors, w)
        outfile = path.join(warriors, w[:-4] + ".rc")
        loadfiles.append(outfile)
        cmd = 'echo ";assert 1\n" > {} && {} -r 0 {} | tail -n +2 >> {}'.format(
            outfile, pmars, infile, outfile
        )
        popen(cmd).read()

    # We can use a with statement to ensure threads are cleaned up promptly
    with concurrent.futures.ProcessPoolExecutor(max_workers=20) as executor:
        # Start the load operations and mark each future with its URL
        futures = [
            executor.submit(run_test, pmars, othermars, w1, loadfiles, num_tests)
            for w1 in loadfiles
        ]
        for future in concurrent.futures.as_completed(futures):
            future.result()

if __name__ == "__main__":
    if len(argv) < 5:
        print(
            "Usage: test-bench.py <path_to_pmars> <path_to_other_mars> <path_to_warrior_dir> <num_tests_per_warrior_pair>"
        )
        exit(0)

    run_tests(argv[1], argv[2], argv[3], int(argv[4]))
